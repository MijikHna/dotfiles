import json
import os
from typing import Literal, TypedDict

import requests


class LineData(TypedDict):
    name: str
    score: dict[
        Literal[
            "maintenance",
            "overall",
            "quality",
            "vulnerability",
            "supplyChain",
            "license",
        ],
        float,
    ]


type PackageJsonContent = dict[
    Literal["dependencies", "devDependencies"], dict[str, str]
]


def fetch_report() -> None:
    org_slug = os.getenv("SLUG")
    token = os.getenv("SOCKET_SECURITY_API_KEY")
    scan_id = os.getenv("SCAN_ID")

    socket_dev_url = f"https://api.socket.dev/v0/orgs/{org_slug}/full-scans/{scan_id}"

    query_params: dict[str, bool | str] = {
        "include_alert_priority_details": False,
        "include_license_details": False,
    }
    headers: dict[str, str] = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/x-ndjson",
        "User-Agent": "Socket Action/0.1",
    }

    try:
        response_data = requests.get(
            socket_dev_url,
            params=query_params,
            headers=headers,
        ).text
    except requests.RequestException as e:
        print(e)
        exit(1)

    overall_values = []
    supply_chain_values = []
    vulnerability_values = []
    quality_values = []
    maintenance_values = []
    license_values = []

    for line in response_data.splitlines():
        try:
            data: LineData = json.loads(line)

            name = data.get("name")

            overall = data.get("score", {}).get("overall", 0)
            supply_chain = data.get("score", {}).get("supplyChain", 0)
            vulnerability = data.get("score", {}).get("vulnerability", 0)
            maintenance = data.get("score", {}).get("maintenance", 0)
            quality = data.get("score", {}).get("quality", 0)
            license_ = data.get("score", {}).get("license", 0)

            overall_values.append(overall)
            supply_chain_values.append(supply_chain)
            vulnerability_values.append(vulnerability)
            maintenance_values.append(maintenance)
            quality_values.append(quality)
            license_values.append(license_)

            # Print the package name and its scores
            if overall < 0.65:
                print(f"Package: {name}")
                print(f"{generate_bar(overall)} {overall:.2f} - Overall")
                print(f"{generate_bar(supply_chain)} {supply_chain:.2f} - Supply Chain")
                print(
                    f"{generate_bar(vulnerability)} {vulnerability:.2f} - Vulnerability"
                )
                print(f"{generate_bar(quality)} {quality:.2f} - Quality")
                print(f"{generate_bar(maintenance)} {maintenance:.2f} - Maintenance")
                print(f"{generate_bar(license_)} {license_:.2f} - License")
                print()
        except json.JSONDecodeError:
            continue

    mean_overall = sum(overall_values) / len(overall_values) if overall_values else 0
    mean_supply_chain = (
        sum(supply_chain_values) / len(supply_chain_values)
        if supply_chain_values
        else 0
    )
    vulnerability_values = (
        sum(vulnerability_values) / len(vulnerability_values)
        if vulnerability_values
        else 0
    )
    mean_maintenance = (
        sum(maintenance_values) / len(maintenance_values) if maintenance_values else 0
    )
    mean_quality = sum(quality_values) / len(quality_values) if quality_values else 0
    mean_license = sum(license_values) / len(license_values) if license_values else 0

    print()
    print("Overall Summary:")
    print(f"{generate_bar(mean_overall)} {mean_overall:.2f} - Overall")
    print(f"{generate_bar(mean_supply_chain)} {mean_supply_chain:.2f} - Supply Chain")
    print(
        f"{generate_bar(vulnerability_values)} {vulnerability_values:.2f} - Vulnerability"
    )
    print(f"{generate_bar(mean_quality)} {mean_quality:.2f} - Quality")
    print(f"{generate_bar(mean_maintenance)} {mean_maintenance:.2f} - Maintenance")
    print(f"{generate_bar(mean_license)} {mean_license:.2f} - License")


def generate_bar(mean: float, length: int = 20) -> str:
    # Calculate the number of filled and empty segments
    filled_length = int(mean * length)
    empty_length = length - filled_length

    # Create the progress bar using ASCII characters
    filled_part = "#" * filled_length
    empty_part = "-" * empty_length

    # Combine the parts
    return f"[{filled_part}{empty_part}]"


def get_packages_from_package_json(file_path: str) -> list[str]:
    with open(file_path, "r") as file:
        data: PackageJsonContent = json.load(file)
    return [
        *data.get("dependencies", {}).keys(),
        *data.get("devDependencies", {}).keys(),
    ]


def get_packages_from_requirements_txt(file_path: str) -> list[str]:
    with open(file_path, "r") as file:
        return [
            line.strip() for line in file if line.strip() and not line.startswith("#")
        ]


if __name__ == "__main__":
    fetch_report()

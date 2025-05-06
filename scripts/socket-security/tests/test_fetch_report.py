from dotenv import load_dotenv

from socket_security.fetch_report import fetch_report

load_dotenv()


def test_fetch_repot() -> None:
    # Arrange
    print()

    # Act
    fetch_report()

    # Accert

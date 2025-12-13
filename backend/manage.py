import argparse
from app.db.commands import create_superuser 

def main():
    parser = argparse.ArgumentParser("Management commands")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("createsuperuser")

    args = parser.parse_args()

    if args.command == "createsuperuser":
        create_superuser()


if __name__ == "__main__":
    main()
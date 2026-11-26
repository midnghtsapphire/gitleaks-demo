"""Tiny toy app for the Gitleaks demo. No real configuration or secrets live here."""


def greeting(name: str = "world") -> str:
    return f"Hello, {name}."


if __name__ == "__main__":
    print(greeting())

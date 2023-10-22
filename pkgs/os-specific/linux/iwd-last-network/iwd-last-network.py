#!/usr/bin/env python3
"""
Script to parse `iwctl known-networks list`
and return the most recently connected network.

iwd version 1.30+.
"""
import datetime
import subprocess


def __known_networks() -> str:
    """Wraps `iwctl known-networks list`."""
    out = subprocess.run(
        ["iwctl", "known-networks", "list"],
        capture_output=True,
        text=True,
    )
    return out.stdout


def get_date(date: str) -> datetime.datetime:
    """Parse iwctl date format into a datetime object."""
    return datetime.datetime.strptime(date, "%b %d, %H:%M %p")


def get_known_networks() -> list[str]:
    """Parses the output of iwctl."""
    lines = __known_networks().strip().splitlines()
    header = lines[2].lower()
    fields = header.split()[1:]
    start = header.find(" ")
    starts = {field: header.find(field) - start for field in fields}
    offset = {
        field: (starts[field], starts.get(next_field, len(header)))
        for field, next_field in zip(fields, fields[1:] + [None])
    }
    get_field = lambda line, field: line[  # noqa: E731
        offset[field][0] + line.find(" ") : offset[field][1] + line.find(" ")
    ].strip()
    return [
        (
            get_field(row, "name"),
            get_field(row, "security"),
            get_field(row, "hidden"),
            get_date(" ".join(row.split()[-4:])),
        )
        for row in lines[4:]
    ]


if __name__ == "__main__":
    lines = get_known_networks()
    recent = sorted(lines, key=lambda row: row[-1], reverse=True)
    print(recent[0][0])

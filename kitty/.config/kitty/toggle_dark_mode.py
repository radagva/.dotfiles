from kittens.tui.handler import result_handler
import subprocess


def main(args): ...


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    subprocess.run(
        [
            "osascript",
            "-e",
            'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode',
        ]
    )

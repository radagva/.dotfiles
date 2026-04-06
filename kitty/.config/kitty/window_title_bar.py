def draw_window_title(data):
    title = data.get("title", "")
    session_name = data.get("active_session_name") or data.get("session_name", "")
    if session_name:
        return f"{session_name} - {title}"
    return title

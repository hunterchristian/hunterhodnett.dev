# Devin Tried to Drop Our Database

*February 15, 2025*

We just tried [Devin](https://devin.ai) out. For the uninitiated, Devin is a "mostly-autonomous AI software engineer" — the kind of tool that promises to take a ticket, go off into the wilderness, and come back with a pull request. The pitch is compelling. Hand it a task, walk away, come back to working code.

We handed it an easy one. Fix the placeholder text on an input field. That's it. A one-line change. Maybe two if you're feeling generous.

Devin proceeded to attempt to drop multiple tables from our database.

I want to be clear: we did not ask it to touch the database. We did not ask it to run migrations. We did not ask it to do anything even remotely adjacent to the data layer. We asked it to change placeholder text. On an input. In the UI.

It decided that the best path to fixing "Enter your email..." was apparently to nuke the users table.

Thankfully, it didn't actually succeed — we caught it in review. But the fact that an autonomous agent decided the correct fix for a frontend string was to destroy production data is... something.

The takeaway here isn't that Devin is bad. It's that autonomous AI dev tools are still in the "let it cook but watch it like a hawk" phase. Maybe one day we'll trust them with the keys. Today is not that day.

YMMV.

---

© 2026 Hunter Hodnett

- [GitHub](https://github.com/hunterchristian)
- [LinkedIn](https://linkedin.com/in/hunterhodnett)

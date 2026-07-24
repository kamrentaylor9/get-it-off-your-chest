# Get It Off Your Chest

A tiny, private web app that turns a messy, stream-of-consciousness vent about how you're
feeling into a clean one-page sheet you can hand to (or read off to) your doctor.

Everything runs in your browser. Nothing you type is sent anywhere — your notes are saved
only on your own device (via `localStorage`).

> Personal prep notes, **not** medical advice. Nothing here is a diagnosis.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The whole app — UI, logic, and styles in one file. |
| `manifest.webmanifest` | App name, colors, and icons so it can be **installed** like an app. |
| `sw.js` | Service worker — makes it installable and work **offline**. |
| `icon.svg` / `icon-maskable.svg` | App icons. |

## Installable app (PWA)

This is a Progressive Web App. When it's served over `http://localhost` or `https://`,
browsers show an **Install** button so it gets its own icon and window, works offline, and
(later) can be added to a phone home screen.

Opening `index.html` directly from your files (a `file://` address) will show the app, but
the browser **won't** offer to install it — that step needs the app to be *served*.

### Ways to run it served
- **Deploy it** to a free static host (e.g. Netlify drag-and-drop, GitHub Pages, Cloudflare
  Pages). You get a real link you can install on a computer or phone.
- **Run a local server** on your machine and open `http://localhost:<port>`.

## Making changes
Everything is plain HTML/CSS/JS — no build step. Edit `index.html` and refresh.
If you change any files, bump the `CACHE` name in `sw.js` (e.g. `chest-v2`) so returning
users pick up the new version.

# WhatChannelAreTheYankeesOn.com — Launch Plan

## Step 1: Register the Domain (DONE)

Purchased on [Porkbun](https://www.porkbun.com) — `whatchannelaretheyankeeeson.com`.

## Step 2: Deploy on GitHub Pages (Free)

### One-time setup (run in Command Prompt or PowerShell):

```
cd C:\Users\Billy\Desktop\Superdev\BBProjectDevelopment\WhatChannelAreTheYankeesOn
git init
git branch -m main
git add index.html privacy.html CNAME Images/ LAUNCH_PLAN.md
git commit -m "Initial launch: Yankees schedule dashboard"
gh repo create WhatChannelAreTheYankeesOn --public --source=. --push
```

Then enable GitHub Pages:
```
gh api repos/YOUR_GITHUB_USERNAME/WhatChannelAreTheYankeesOn/pages -X POST -f source.branch=main -f source.path=/
```

Or do it in the browser: go to your repo → Settings → Pages → Source: "Deploy from a branch" → Branch: `main` → Folder: `/ (root)` → Save.

## Step 3: Connect Custom Domain

In **Porkbun**, go to your domain's DNS settings and add these records:

| Type  | Host | Value |
|-------|------|-------|
| CNAME | www  | YOUR_GITHUB_USERNAME.github.io |
| A     |  @   | 185.199.108.153 |
| A     |  @   | 185.199.109.153 |
| A     |  @   | 185.199.110.153 |
| A     |  @   | 185.199.111.153 |

DNS propagation takes 15 minutes to 48 hours. GitHub automatically provisions a free SSL certificate.

The `CNAME` file in the repo tells GitHub Pages to serve your site at `whatchannelaretheyankeeeson.com`.

## Step 4: Apply for Google AdSense

Google requires your site to be live with real content before approving.

1. Privacy Policy page is already built (`privacy.html`) and linked in the footer.
2. About section is already in the footer.
3. Go to [adsense.google.com](https://www.google.com/adsense/) and sign up with your Google account.
4. Google will give you a verification `<script>` tag — paste it back to Claude and we'll add it to `index.html`.
5. Submit for review. Approval typically takes 1–7 days.
6. Once approved, we'll swap in your real AdSense publisher ID and ad slot IDs.

## Step 5: Post-Launch Checklist

- **Google Search Console**: Submit your site at [search.google.com/search-console](https://search.google.com/search-console) so Google indexes your pages.
- **Analytics**: Add Google Analytics to track visitors — helps with AdSense optimization.
- **Mobile testing**: Open the site on your phone and verify the responsive layout.
- **Performance**: Run a Lighthouse audit in Chrome DevTools.

## Cost Summary

| Item | Cost |
|------|------|
| Domain (.com, Porkbun) | ~$9–10/year |
| GitHub Pages hosting | Free |
| SSL certificate | Free (via GitHub) |
| Google AdSense | Free to apply |
| **Total to launch** | **~$10** |

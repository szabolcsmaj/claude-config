# UI Style Specification Generator

You are helping the user create a comprehensive UI style specification by analyzing URLs using **dual analysis**: text-based HTML extraction AND visual screenshot analysis.

**Purpose:** This analysis produces a **style guide** that serves as the foundation for creating new page specifications. The resulting `STYLE_GUIDE.md` ensures visual consistency when designing and implementing new pages or features.

## Input

Reference URL: $ARGUMENTS

---

## Analysis Architecture

This skill uses **parallel subagents** for comprehensive style extraction:

```
┌─────────────────────────────────────────────────────────────────┐
│                      MAIN ORCHESTRATOR                          │
│  1. Discover URLs from main page                                │
│  2. Launch parallel subagents for each URL                      │
│  3. Merge findings from all sources                             │
└─────────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────┐
│   WebFetch Subagents    │     │ agent-browser Subagents │
│   (Text/HTML Analysis)  │     │  (Visual Screenshots)   │
│                         │     │                         │
│ • CSS class extraction  │     │ • 1 full screenshot/page│
│ • Framework detection   │     │ • Actual rendered colors│
│ • Link/meta analysis    │     │ • Real typography       │
│ • Structure parsing     │     │ • Visual hierarchy      │
│                         │     │                         │
│ Runs in PARALLEL        │     │ Runs in PARALLEL        │
└─────────────────────────┘     └─────────────────────────┘
              │                               │
              └───────────────┬───────────────┘
                              ▼
                 ┌─────────────────────────┐
                 │    MERGED FINDINGS      │
                 │ • Cross-validate data   │
                 │ • Resolve conflicts     │
                 │ • Generate final spec   │
                 └─────────────────────────┘
```

**Output directory:** `./style-analysis-{sanitized-domain}/` (created in current working directory)

Example: For `https://www.example-site.com`, creates `./style-analysis-www-example-site-com/`

---

## UI Design Styles Reference Database

Use this reference to classify analyzed pages. Match against one or more styles, or identify if it's a new style not in this list.

### Structural/Layout Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Brutalist** | Raw, intentionally unpolished, exposed structure, system fonts, harsh/clashing colors, visible borders, no decoration | Craigslist, early HN, some art portfolios |
| **Bento Grid** | Asymmetric grid of varied-size boxes, feature showcases, mixed content types per cell | Apple product pages, many SaaS landing pages |
| **Editorial/Magazine** | Typography-dominant, dramatic whitespace, layered elements, pull quotes, large imagery | Medium, NYT, Stripe blog |
| **Dashboard Dense** | Information-dense, compact spacing, data-first, small fonts, many widgets | Linear, Datadog, Grafana, trading platforms |
| **Card-Based** | Everything in distinct card containers, uniform or masonry grid | Trello, Pinterest, Notion databases |
| **Single Column** | Focused vertical scroll, minimal navigation, content-centered | Notion docs, Medium articles, Substack |
| **Split Screen** | Two distinct panels, often 50/50 or 60/40, contrasting content | Many landing pages, comparison tools |
| **Infinite Canvas** | Zoomable, pannable workspace, no fixed boundaries | Figma, Miro, Excalidraw |

### Surface/Material Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Glassmorphism** | Frosted glass effect, backdrop-blur, transparency, layered panels, light borders | macOS Big Sur+, many modern dashboards |
| **Neumorphism/Soft UI** | Soft inset/outset shadows, extruded elements, monochromatic, subtle depth | Calculator apps, some banking UIs |
| **Claymorphism** | 3D clay-like appearance, inflated/puffy shapes, playful colored shadows, rounded | Illustrations, playful apps |
| **Flat Design** | Zero shadows, solid colors, no gradients, crisp edges, minimal depth | Windows 8 Metro, early iOS 7+ |
| **Material Design** | Elevation shadows, ripple effects, FABs, specific motion curves, paper metaphor | Google apps, Android native |
| **Skeuomorphism** | Realistic textures, mimics physical objects, leather/wood/metal textures | Old iOS (pre-7), vintage apps |
| **Gradient Mesh** | Complex multi-color gradients, blob shapes, vibrant color transitions | Stripe, modern SaaS marketing |

### Aesthetic/Mood Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Corporate Minimal** | Clean, safe, generous whitespace, muted colors, professional | Stripe dashboard, Notion, Linear |
| **Dark Mode Native** | Designed dark-first (not inverted light), careful contrast, glowing accents | Discord, Spotify, VS Code, Vercel |
| **Maximalist** | Busy, layered, decorative, many competing elements, bold patterns | Fashion sites, some gaming UIs |
| **Retro/Y2K** | 90s-2000s aesthetics, pixel elements, gradients, chunky borders, nostalgia | Poolsuite, some indie games |
| **Cyberpunk/Neon** | Dark backgrounds, neon accent colors (cyan, magenta, green), tech-noir, glitch effects | Gaming dashboards, hacker tools |
| **Organic/Natural** | Earth tones (greens, browns, creams), rounded shapes, nature imagery, calm | Wellness apps, eco brands |
| **Memphis Design** | Bold geometric shapes, clashing bright colors, playful, 80s revival | Figma marketing, creative tools |
| **Swiss/International** | Strict grid, Helvetica-style sans-serif, functional, minimal decoration | Many corporate sites, gov sites |
| **Bauhaus** | Primary colors (red/blue/yellow + black/white), geometric shapes, functional | Art institutions, design portfolios |
| **Art Deco** | Geometric patterns, gold/brass accents, symmetry, luxury feel, ornate | Luxury brands, hotels, finance |
| **Vaporwave** | Pastels (pink, cyan, purple), gradients, retro-futuristic, surreal, 80s references | Music apps, aesthetic projects |
| **Monochrome** | Single color family, relies on shades/tints, typography-focused | Many developer tools, minimal portfolios |

### Interaction-Defined Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Command-Palette First** | Keyboard-driven, cmd+k searchable, minimal mouse needed, power-user focused | Raycast, Linear, Superhuman, VS Code |
| **Gesture-Based** | Swipe actions, drag-to-reorder, touch-optimized, mobile-first patterns | Tinder, iOS Mail, many mobile apps |
| **Wizard/Step-Flow** | Progressive disclosure, numbered steps, guided flows, one thing at a time | Onboarding flows, Typeform |
| **Conversational** | Chat-like interface, message bubbles, AI assistant patterns | ChatGPT, Intercom, support widgets |

### Hybrid/Trending Styles (2023-2025)

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Linear-Style** | Dark + purple/blue accents, command palette, dense but clean, keyboard-first | Linear, Raycast, Arc |
| **Notion-Style** | Block-based, slash commands, inline editing, flexible layouts, wiki-like | Notion, Coda, Craft |
| **Vercel-Style** | Minimal, lots of black/white, subtle gradients, developer-focused, clean | Vercel, Next.js docs |
| **Stripe-Style** | Gradients + clean UI, excellent docs, animated illustrations, polished | Stripe, modern fintech |

---

## Style-Based Inference Defaults

When analysis doesn't capture certain states or behaviors, use these style-specific defaults. **These are inferences, not extractions.**

### Responsive Breakpoints by Style

| Style | Mobile | Tablet | Desktop | Wide | Notes |
|-------|--------|--------|---------|------|-------|
| **Linear-Style** | 640px | 768px | 1024px | 1280px | Sidebar collapses at tablet |
| **Notion-Style** | 640px | 768px | 1024px | 1440px | Full-width option common |
| **Vercel-Style** | 640px | 768px | 1024px | 1280px | Content max-width ~720px |
| **Stripe-Style** | 640px | 768px | 1024px | 1440px | Marketing uses wider breakpoints |
| **Dashboard Dense** | 480px | 768px | 1024px | 1440px | Often desktop-first |
| **Card-Based** | 640px | 768px | 1024px | 1280px | Cards stack on mobile |
| **Editorial/Magazine** | 640px | 768px | 1024px | 1200px | Narrow content column |
| **Corporate Minimal** | 640px | 768px | 1024px | 1280px | Standard Tailwind defaults |
| **Material Design** | 600px | 905px | 1240px | 1440px | Material breakpoints |
| **Glassmorphism** | 640px | 768px | 1024px | 1280px | Effects may simplify on mobile |
| **Default** | 640px | 768px | 1024px | 1280px | Tailwind defaults |

### Loading States by Style

| Style | Primary Loading | Skeleton Style | Spinner Style | Notes |
|-------|-----------------|----------------|---------------|-------|
| **Linear-Style** | Skeleton | Subtle shimmer, matches bg | Thin circular, primary color | Minimal, non-distracting |
| **Notion-Style** | Skeleton | Block-shaped, gray pulse | Dots or subtle spinner | Matches block-based UI |
| **Vercel-Style** | Skeleton | Clean gray shimmer | Minimal line spinner | Very subtle, fast |
| **Stripe-Style** | Skeleton + Shimmer | Gradient shimmer effect | Branded spinner | Polished feel |
| **Dashboard Dense** | Skeleton | Compact, matches data density | Small inline spinners | Per-widget loading |
| **Card-Based** | Skeleton | Card-shaped placeholders | Center of card | Preserve layout during load |
| **Material Design** | Progress indicator | Linear or circular progress | Material circular | Follows Material spec |
| **Glassmorphism** | Blur + Skeleton | Frosted placeholder | Glowing ring spinner | Maintains glass effect |
| **Corporate Minimal** | Skeleton | Simple gray blocks | Subtle spinner | Professional, understated |
| **Brutalist** | Text indicator | "Loading..." text | None or basic | Intentionally raw |
| **Default** | Skeleton | Gray pulse animation | Circular spinner | Standard approach |

### Empty States by Style

| Style | Illustration | Copy Style | CTA Approach | Layout |
|-------|--------------|------------|--------------|--------|
| **Linear-Style** | Minimal/geometric | Concise, action-oriented | Ghost button | Centered, compact |
| **Notion-Style** | Friendly illustration | Helpful, guides next action | Inline suggestions | Centered with tips |
| **Vercel-Style** | None or minimal icon | Direct, technical | Primary button | Minimal, centered |
| **Stripe-Style** | Custom illustration | Friendly but professional | Clear CTA button | Centered, spacious |
| **Dashboard Dense** | Small icon only | Brief, functional | Link or small button | Fits in widget space |
| **Card-Based** | Placeholder card | Suggests creating content | "Add" button prominent | Card-shaped empty state |
| **Material Design** | Material icon/illustration | Follows Material guidelines | FAB or button | Centered, follows spec |
| **Corporate Minimal** | Subtle illustration | Professional, helpful | Secondary button | Generous whitespace |
| **Brutalist** | None | Plain text, direct | Text link | Raw, minimal |
| **Default** | Simple icon | Helpful message | Primary CTA | Centered |

### Error States by Style

| Style | Display Method | Severity Indication | Recovery UX | Toast Position |
|-------|----------------|---------------------|-------------|----------------|
| **Linear-Style** | Toast + inline | Color-coded borders | Retry button, clear message | Bottom-right |
| **Notion-Style** | Inline + toast | Red highlight, icon | Undo option, helpful text | Bottom-center |
| **Vercel-Style** | Toast | Minimal, red accent | Clear retry action | Top-right |
| **Stripe-Style** | Inline + toast | Color + icon + text | Step-by-step recovery | Top-right |
| **Dashboard Dense** | Inline badges | Compact indicators | Quick actions | Bottom-right |
| **Material Design** | Snackbar | Material error colors | Action button in snackbar | Bottom-center |
| **Corporate Minimal** | Toast + inline | Subtle but clear | Professional error copy | Top-right |
| **Default** | Toast | Red color, icon | Retry button | Top-right |

### Mobile Navigation by Style

| Style | Primary Pattern | Gesture Support | Bottom Nav | Hamburger Style |
|-------|-----------------|-----------------|------------|-----------------|
| **Linear-Style** | Slide-out drawer | Swipe to open | No | Minimal icon |
| **Notion-Style** | Bottom sheet + drawer | Swipe gestures | Tab bar optional | Menu icon |
| **Vercel-Style** | Hamburger → drawer | Minimal | No | Simple icon |
| **Stripe-Style** | Hamburger → overlay | Smooth transitions | No | Animated icon |
| **Dashboard Dense** | Bottom nav + hamburger | Limited | Yes, 4-5 items | Compact |
| **Card-Based** | Bottom nav | Swipe between cards | Yes | Standard |
| **Material Design** | Bottom nav / drawer | Material gestures | Yes, Material spec | Material hamburger |
| **Gesture-Based** | Bottom nav + gestures | Full swipe support | Yes | Minimal or none |
| **Corporate Minimal** | Hamburger → overlay | Basic | Optional | Clean icon |
| **Default** | Hamburger → drawer | Basic swipe | Optional | Standard icon |

### Accessibility Defaults by Style

| Style | Min Contrast | Focus Style | Touch Target | Motion | Screen Reader |
|-------|--------------|-------------|--------------|--------|---------------|
| **Linear-Style** | 4.5:1 | Ring, primary color | 44px | Reduced motion support | ARIA labels |
| **Notion-Style** | 4.5:1 | Outline + background | 44px | Respects prefers-reduced-motion | Full ARIA |
| **Vercel-Style** | 7:1 (high contrast) | Subtle ring | 44px | Minimal animations | Semantic HTML |
| **Stripe-Style** | 4.5:1 | Branded focus ring | 48px | Respects preference | Comprehensive |
| **Dashboard Dense** | 4.5:1 | Clear outline | 32px min | Performance-focused | Data table ARIA |
| **Material Design** | 4.5:1 | Material ripple + outline | 48px | Material motion | Material a11y |
| **Dark Mode Native** | 4.5:1 on dark | Glow/ring | 44px | Dark-optimized | ARIA labels |
| **Default** | 4.5:1 WCAG AA | 2px ring, offset | 44px | prefers-reduced-motion | ARIA landmarks |

### Page Layout Patterns by Style

| Style | Content Width | Sidebar | Header | Grid System |
|-------|---------------|---------|--------|-------------|
| **Linear-Style** | Full - sidebar | Collapsible, 240-280px | Fixed, compact | Custom flex/grid |
| **Notion-Style** | Centered, max 900px | Collapsible, 240px | Minimal/hidden | Block-based |
| **Vercel-Style** | Centered, max 720px | None or minimal | Fixed, minimal | Simple centered |
| **Stripe-Style** | Varied by page type | Docs: 280px, App: none | Contextual | 12-column |
| **Dashboard Dense** | Full width | Fixed, 200-260px | Compact with breadcrumbs | Dense grid |
| **Card-Based** | Full with padding | Optional | Standard | Masonry or grid |
| **Editorial/Magazine** | Narrow, 680-720px | None | Prominent | Single column |
| **Corporate Minimal** | Centered, max 1200px | Optional | Clean, spacious | 12-column |
| **Default** | Centered, max 1280px | Optional | Standard | 12-column |

---

## Your Task

### Step 0: Initialize Analysis Environment

Before starting, create the output directory for screenshots and analysis files:

**Directory Naming Convention:**
1. Extract the domain from the URL (e.g., `www.example-site.com` from `https://www.example-site.com/docs`)
2. Convert ALL non-alphanumeric characters to `-` (dots, hyphens, underscores, etc.)
3. Create directory: `style-analysis-{sanitized-domain}`

**Examples:**
| URL | Output Directory |
|-----|------------------|
| `https://www.stripe.com` | `./style-analysis-www-stripe-com/` |
| `https://linear.app/features` | `./style-analysis-linear-app/` |
| `https://docs.github.com` | `./style-analysis-docs-github-com/` |
| `https://my-site.example.co.uk` | `./style-analysis-my-site-example-co-uk/` |

**Create the directory structure:**
```bash
# Replace {sanitized-domain} with the actual sanitized domain name
mkdir -p ./style-analysis-{sanitized-domain}/screenshots
mkdir -p ./style-analysis-{sanitized-domain}/html
mkdir -p ./style-analysis-{sanitized-domain}/reports
```

**Store the base path** for use throughout the analysis:
```
BASE_DIR="./style-analysis-{sanitized-domain}"
```

### Step 1: Analyze Main URL and Discover Subpages

**First**, use WebFetch on the main URL to:
1. Extract the base domain
2. Find all internal links in the page
3. Identify the page type (Marketing, Docs, App, etc.)

**URL Discovery Rules:**
- Extract internal links from the main page's HTML
- Look for navigation menus, footers, and sitemap links
- **CRITICAL: Limit to 1 URL per page type** - Do NOT analyze multiple pages of the same type (e.g., if you find 5 blog posts, only include 1 representative blog post URL)
- Identify common patterns:

| Pattern | URL Paths to Check |
|---------|-------------------|
| Documentation | `/docs`, `/documentation`, `/guide`, `/learn`, `/api` |
| Pricing | `/pricing`, `/plans`, `/upgrade` |
| Blog | `/blog`, `/articles`, `/news`, `/changelog` |
| Features | `/features`, `/product`, `/solutions` |
| Auth | `/login`, `/signin`, `/signup`, `/register` |
| About | `/about`, `/team`, `/company`, `/careers` |
| Contact | `/contact`, `/support`, `/help` |
| Legal | `/privacy`, `/terms`, `/legal` |
| Demo | `/demo`, `/playground`, `/examples` |

**⚠️ ONE URL PER PAGE TYPE RULE:**

When you discover multiple URLs of the same page type, select only ONE representative URL. Pages of the same type share the same layout/template with different content.

| Page Type | Example: Multiple Found | Select Only |
|-----------|------------------------|-------------|
| Blog Post | `/blog/post-1`, `/blog/post-2`, `/blog/post-3` | `/blog/post-1` (just 1) |
| Documentation Page | `/docs/getting-started`, `/docs/api-reference` | `/docs/getting-started` (just 1) |
| Product Page | `/products/item-a`, `/products/item-b` | `/products/item-a` (just 1) |
| Team Member | `/team/john`, `/team/jane` | `/team/john` (just 1) |
| Case Study | `/case-studies/company-a`, `/case-studies/company-b` | `/case-studies/company-a` (just 1) |

**Selection criteria for the ONE representative URL:**
1. Prefer the first/most prominent link found
2. Prefer pages with more visual content (images, components)
3. Prefer pages that appear to be complete (not empty or placeholder)

**Exception:** Different page TYPES are allowed (e.g., `/blog` index page AND one `/blog/post-1` detail page are different types - index vs. detail)

### Step 1.5: MANDATORY - Print URL List Before Analysis

**⚠️ CRITICAL: You MUST print the complete URL list and get user confirmation BEFORE launching any analysis subagents.**

After discovering URLs, ALWAYS output this to the user:

```markdown
═══════════════════════════════════════════════════════════════════
                    📋 URLs TO BE ANALYZED
═══════════════════════════════════════════════════════════════════

Base Domain: [extracted domain]
Total URLs: [count]

## URLs for Analysis (1 per page type):

| # | URL | Page Type | Analysis | Duplicates Skipped |
|---|-----|-----------|----------|-------------------|
| 1 | [full URL] | Marketing | WebFetch + Visual | - |
| 2 | [full URL] | Documentation | WebFetch + Visual | 3 other doc pages |
| 3 | [full URL] | Pricing | WebFetch + Visual | - |
| 4 | [full URL] | Blog Post | WebFetch + Visual | 5 other blog posts |
| ... | ... | ... | ... | ... |

**Note:** Only 1 URL per page type is analyzed. Pages with identical layouts (same type, different content) are skipped.

## Analysis Plan:
- WebFetch subagents: [count] (1 per URL)
- agent-browser subagents: [count] (1 per URL, 1 screenshot each)
- Total subagents: [count × 2]
- Total screenshots: [count] (1 full-page screenshot per URL)
- Screenshots will be saved to: {BASE_DIR}/screenshots/

═══════════════════════════════════════════════════════════════════
```

**Then ASK the user:**
- "I found [N] unique page types to analyze (duplicates with same layout were skipped). Should I proceed with all of them?"
- "Would you like to add any URLs to this list?"
- "Would you like to remove any URLs from this list?"
- "For any page type with skipped duplicates, would you prefer a different representative URL?"
- "Are there specific page types you want me to prioritize?"

**ONLY proceed to Step 2 after user confirms the URL list.**

If the user wants changes:
- Add requested URLs to the list
- Remove unwanted URLs
- Re-print the updated list
- Confirm again before proceeding

### Step 2: Launch Parallel Analysis Subagents

**CRITICAL:** Launch ALL subagents in PARALLEL using Task tool with multiple tool calls in a single message.

For each URL in your list, spawn TWO types of subagents simultaneously:

#### A. WebFetch Subagents (Text/HTML Analysis)

For each URL, spawn a subagent with this prompt template:

```
Use WebFetch to analyze [URL] and extract UI style information.

Save your findings to: {BASE_DIR}/html/[sanitized-url-slug].md

Extract and report:

## URL: [URL]
## Page Type: [identify type]

### HTML/CSS Analysis

#### Detected Frameworks
- CSS Framework: [Tailwind/Bootstrap/custom - look for class patterns]
- Component Library: [shadcn/Radix/Headless UI/etc - look for data attributes, class patterns]
- Icon Library: [look for icon class patterns, SVG sources]

#### Colors Found in HTML
- Inline styles with colors: [list hex/rgb values]
- CSS variable references: [--color-*, --bg-*, etc.]
- Tailwind color classes: [bg-blue-500, text-gray-900, etc.]
- Background colors: [list]
- Text colors: [list]
- Border colors: [list]
- Accent/brand colors: [list]

#### Typography from HTML
- Font family declarations: [font-*, fontFamily]
- Google Fonts/Adobe links: [extract font names]
- Font size classes/values: [list]
- Font weight patterns: [list]

#### Spacing & Layout
- Container patterns: [max-w-*, container, wrapper classes]
- Grid/flex patterns: [grid-cols-*, flex, gap-*]
- Padding/margin patterns: [p-*, m-*, px-*, etc.]
- Border radius patterns: [rounded-*, border-radius values]

#### Component Patterns
- Button classes/patterns: [btn, button, primary, secondary]
- Card patterns: [card, panel, box with shadows]
- Form input patterns: [input styles, focus states]
- Navigation patterns: [nav, sidebar, header]

#### Meta Information
- Theme color meta tags
- Dark mode indicators: [dark:*, .dark, data-theme]
- Viewport/responsive indicators

### Raw CSS Classes Found
[List unique CSS classes that indicate styling patterns]

### Confidence Notes
[What you're confident about vs. uncertain]
```

#### B. agent-browser Subagents (Visual Analysis)

For each URL, spawn an agent-browser subagent with this prompt template:

```
Use the agent-browser skill to visually analyze [URL] for UI style extraction.

## Your Tasks:

### 1. Navigate to Page
- Use agent-browser to navigate to [URL]
- WAIT for the page to be COMPLETELY loaded (wait for network idle, all images loaded, no spinners)

### 2. Take Full Page Screenshot
Once the page is fully loaded, run this command:
```
agent-browser screenshot --full {BASE_DIR}/screenshots/[slug].png
```

This captures ONE full-page screenshot of the entire page.

### 3. Visual Analysis
After capturing the screenshot, analyze what you SEE in the full page screenshot.

Save your visual analysis to: {BASE_DIR}/reports/[slug]-visual.md

## Visual Analysis: [URL]

### Screenshot
- Path: {BASE_DIR}/screenshots/[slug].png

### Overall Impression
- Primary mood/feeling: [describe]
- Visual density: [sparse/moderate/dense]
- Color temperature: [warm/cool/neutral]
- Professional level: [casual/professional/enterprise]

### Color Analysis (from what you SEE)
| Role | Approximate Color | Where Used |
|------|-------------------|------------|
| Primary brand | [color name + hex estimate] | [locations] |
| Background | [color] | [locations] |
| Text primary | [color] | [locations] |
| Text secondary | [color] | [locations] |
| Accent/CTA | [color] | [locations] |
| Borders | [color] | [locations] |

### Typography Visual Analysis
- Heading style: [serif/sans-serif, weight, approximate size]
- Body text: [font style, size, line spacing]
- Special text: [any standout typography]
- Text contrast: [high/medium/low]

### Layout Observations
- Grid structure: [describe what you see]
- Whitespace usage: [generous/moderate/tight]
- Content width: [narrow/medium/wide/full]
- Symmetry: [symmetric/asymmetric]

### Component Styles Observed
- Buttons: [shape, size, shadow, border]
- Cards: [shadow depth, border, radius]
- Icons: [style - line/filled/duotone, size]
- Images: [treatment - rounded, shadow, borders]
- Forms (if visible): [input style, labels]
- Navigation: [style, position, layout]
- Footer: [style, content organization]

### Style Classification Guess
Based on visuals, this appears to match: [style from database]
Confidence: [high/medium/low]
Reasoning: [why]
```

#### Launch Pattern

You MUST launch these as parallel subagents. Example for 3 URLs:

```
[Launch 6 subagents in parallel - 2 per URL]

Task 1: WebFetch analysis for main URL
Task 2: agent-browser visual analysis for main URL
Task 3: WebFetch analysis for /docs
Task 4: agent-browser visual analysis for /docs
Task 5: WebFetch analysis for /pricing
Task 6: agent-browser visual analysis for /pricing
```

### Step 3: Collect and Merge Subagent Results

After all subagents complete:

1. **Read all report files** from `{BASE_DIR}/reports/`
2. **Review screenshots** from `{BASE_DIR}/screenshots/`
3. **Cross-validate** findings between WebFetch and visual analysis

```markdown
## Cross-Validation Report

### Color Comparison
| Color Role | WebFetch Found | Visual Found | Confidence | Final Value |
|------------|----------------|--------------|------------|-------------|
| Primary | #xxx (from classes) | ~blue (from screenshot) | High | #xxx |
| ... | | | | |

### Typography Comparison
| Element | WebFetch Found | Visual Found | Final |
|---------|----------------|--------------|-------|
| Heading font | Inter (from Google link) | Sans-serif, medium weight | Inter |
| ... | | | |

### Conflicts Resolved
- [List any discrepancies and how you resolved them]

### Visual-Only Discoveries
- [Things only visible in screenshots, not in HTML]

### HTML-Only Discoveries
- [Things in HTML but not visually apparent - hidden elements, dark mode styles, etc.]
```

### Step 4: Match Against Style Reference Database

**CRITICAL STEP:** Compare merged findings against the UI Design Styles Reference Database above.

Use BOTH the HTML analysis AND the visual screenshots to make this determination.

Determine:
1. **Primary Style Match:** Which style from the database best describes this site? (Pick 1)
2. **Secondary Style Influences:** What other styles are present? (Pick 0-3)
3. **Confidence Level:** How well does it match? (Strong match / Partial match / Weak match)
4. **Style Varies by Page Type?** Note if marketing vs. product have different styles.

**If NO style matches well:**
- Describe the unique characteristics that don't fit existing categories
- Propose a NEW style name and definition
- Ask: "This appears to be a style not in my reference database. I'd call it **[Proposed Name]** characterized by [characteristics]. Should I add this to the style reference for future use?"

Present the style matching:

```markdown
## Style Classification

### Primary Style: [Style Name]
**Confidence:** [Strong/Partial/Weak]
**Best represented on:** [which page type]
**Evidence from HTML:** [what classes/patterns support this]
**Evidence from Screenshots:** [what visual elements support this]
**Matching characteristics:**
- [bullet points of what matches]

### Secondary Influences:
- **[Style Name]:** [which elements match, on which pages]
- **[Style Name]:** [which elements match, on which pages]

### Style by Page Type:
| Page Type | Primary Style | Notes |
|-----------|---------------|-------|
| Marketing | [style] | [notes] |
| Docs | [style] | [notes] |
| App | [style] | [notes] |

### Deviations from Standard:
- [What differs from the matched style's typical implementation]
```

### Step 4.5: Style-Based Inference for Missing Elements

**CRITICAL:** After classifying the style, use the "Style-Based Inference Defaults" tables above to fill in gaps that cannot be determined from the analyzed pages.

**Determine what's missing from the analysis:**

```markdown
## Analysis Coverage Report

### States/Views Captured:
- [ ] Default/normal state (likely ✓ from screenshots)
- [ ] Hover states (may be visible if captured during interaction)
- [ ] Active/pressed states
- [ ] Focus states
- [ ] Loading states (only if page happened to be loading)
- [ ] Empty states (only if visible on analyzed pages)
- [ ] Error states (only if visible on analyzed pages)
- [ ] Success states
- [ ] Disabled states

### Viewports Captured:
- [ ] Desktop only (most likely from agent-browser)
- [ ] Mobile viewport (if specifically requested)
- [ ] Tablet viewport

### What We CANNOT Determine from This Analysis:
- [ ] Responsive breakpoints (screenshots are single viewport)
- [ ] Loading state appearance (unless page was loading during capture)
- [ ] Empty state design (unless visible on analyzed pages)
- [ ] Error handling UI (unless visible on analyzed pages)
- [ ] Mobile navigation pattern (unless mobile screenshots taken)
- [ ] Accessibility specifics (focus rings, motion preferences)
- [ ] Page layout variations at different breakpoints
```

**Apply Style-Based Inference:**

Based on the **[Primary Style]** classification, look up defaults in the inference tables:

```markdown
## Style-Based Inferences (for [Primary Style])

> ⚠️ **INFERRED** - The following are style-consistent suggestions, NOT extracted from the analyzed URLs.
> Override these if you have access to actual designs or different requirements.

### 🔮 Responsive Breakpoints (Inferred)
| Breakpoint | Value | Behavior |
|------------|-------|----------|
| Mobile | [from table] | [behavior from table] |
| Tablet | [from table] | |
| Desktop | [from table] | |
| Wide | [from table] | |

### 🔮 Loading States (Inferred)
- **Primary method:** [from table]
- **Skeleton style:** [from table]
- **Spinner style:** [from table]
- **Notes:** [from table]

### 🔮 Empty States (Inferred)
- **Illustration:** [from table]
- **Copy style:** [from table]
- **CTA approach:** [from table]
- **Layout:** [from table]

### 🔮 Error States (Inferred)
- **Display method:** [from table]
- **Severity indication:** [from table]
- **Recovery UX:** [from table]
- **Toast position:** [from table]

### 🔮 Mobile Navigation (Inferred)
- **Primary pattern:** [from table]
- **Gesture support:** [from table]
- **Bottom nav:** [from table]
- **Hamburger style:** [from table]

### 🔮 Accessibility Defaults (Inferred)
- **Min contrast:** [from table]
- **Focus style:** [from table]
- **Touch target:** [from table]
- **Motion:** [from table]
- **Screen reader:** [from table]

### 🔮 Page Layout (Inferred)
- **Content width:** [from table]
- **Sidebar:** [from table]
- **Header:** [from table]
- **Grid system:** [from table]
```

**Ask user to confirm or override inferences:**
- "I've inferred [X, Y, Z] based on the **[Style]** classification. These are marked with 🔮 in the spec. Would you like to:"
  - Accept these defaults
  - Analyze additional URLs that show these states
  - Specify different values

### Step 5: Present Consolidated Findings

Merge findings from all analyzed pages and both analysis methods:

```markdown
## Extracted Style Specification

### Analysis Summary
- **URLs Analyzed:** [count]
- **WebFetch Reports:** [count] (1 per URL)
- **Visual Screenshots:** [count] (1 per URL)
- **Analysis Session:** {BASE_DIR}/

### Pages Analyzed
| # | URL | Page Type | WebFetch | Visual | Style Match |
|---|-----|-----------|----------|--------|-------------|
| 1 | [url] | Marketing | ✓ | ✓ | [style] |
| 2 | [url] | Docs | ✓ | ✓ | [style] |
...

### Style Classification
[From Step 4]

### Colors (Consolidated from both sources)
| Role | Hex | Source | Confidence | Usage |
|------|-----|--------|------------|-------|
| Primary | #xxx | WebFetch + Visual | High | Buttons, links |
| Secondary | #xxx | Visual only | Medium | CTAs |
| Background | #xxx | WebFetch (Tailwind) | High | Page bg |
| ... | | | | |

### Typography
- Headings: [Font Family] - Source: [Google Fonts link / Visual identification]
- Body: [Font Family], base size: [value]
- Mono/Code: [Font Family] (found on: docs, blog)
- **Visual notes:** [any typography observations from screenshots]

### Framework/Libraries Detected
- CSS: [Tailwind / Bootstrap / UnoCSS / Custom] - Confidence: [level]
- Components: [Detected library] - Evidence: [class patterns / visual patterns]
- Icons: [Detected or "Unknown"] - Evidence: [source]

### Measurements (from HTML classes + visual estimation)
- Border radius: [values by page type]
- Base spacing unit: [estimated]
- Container max-width: [value]
- Shadows: [description]

### Layout Patterns by Page Type
- Marketing: [description + screenshot reference]
- Docs: [description + screenshot reference]
- App: [description + screenshot reference]

### Screenshots (1 per page)
Reference these for visual details:
- Main page: {BASE_DIR}/screenshots/main.png
- Docs: {BASE_DIR}/screenshots/docs.png
- Pricing: {BASE_DIR}/screenshots/pricing.png
- [one screenshot per analyzed URL]
```

### Step 6: Interactive Clarification

After presenting findings, ASK the user:

1. **Page Type Preference:**
   - "Your marketing site and product pages have different styles. Which do you want to base your spec on?"
   - "Should I create separate specs for marketing vs. app pages?"

2. **Style Confirmation:**
   - "I classified this as **[Style]** with **[Secondary]** influences. Does that match your intent?"
   - "Here are the screenshots - do they match what you expected? [reference screenshot paths]"
   - If new style proposed: "Should I add **[Proposed Style]** to the reference database?"

3. **Missing Information:**
   - "I couldn't detect the icon library. Do you want: Lucide, Heroicons, Phosphor, Tabler, or custom SVGs?"
   - "The component library isn't clear. For Nuxt, would you prefer: Nuxt UI, shadcn-vue, Radix Vue, PrimeVue, or Headless UI?"

4. **Contradictions or Choices:**
   - "The site uses both sharp (docs) and rounded (marketing) corners. Which do you prefer?"
   - "I see both card-based and list layouts. What's your primary content display preference?"
   - "WebFetch found [X] but visually I saw [Y]. Which should we use?"

5. **Deeper Style Questions:**
   - "How should loading states appear? (Skeletons / Spinners / Shimmer / None)"
   - "What's your button interaction style? (Scale / Color shift / Shadow lift / Ripple)"
   - "Empty states: Illustrated / Minimal text / Call-to-action focused?"
   - "Form style: Floating labels / Stacked / Inline / Bordered inputs?"
   - "Navigation pattern: Sidebar / Top bar / Command palette / Breadcrumbs?"

6. **Additional URLs:**
   - "Do you have additional URLs to reference for specific components? (e.g., a page with good table design, a settings page)"
   - "Any other products whose [tables/forms/dashboards/etc.] you'd like to emulate?"

7. **Anti-Patterns:**
   - "What should this NOT look like? Any styles from the reference to explicitly avoid?"

### Step 7: Generate Final Specification

After gathering all input, produce a complete specification file.

**IMPORTANT: Use these markers consistently throughout the specification:**

| Marker | Meaning | When to Use |
|--------|---------|-------------|
| 📷 | **Extracted (Visual)** | Observed in screenshots |
| 🔍 | **Extracted (HTML)** | Found in HTML/CSS analysis |
| 📷🔍 | **Extracted (Both)** | Confirmed by both visual and HTML analysis |
| 🔮 | **Inferred** | Derived from style classification, not visible in analysis |
| ✏️ | **User-specified** | Explicitly provided by the user during clarification |
| ⚠️ | **Needs verification** | Estimated values that should be verified |

```markdown
# UI Style Specification: [Project Name]

## Specification Legend

| Symbol | Meaning |
|--------|---------|
| 📷 | **Extracted from screenshots** - Observed in visual analysis |
| 🔍 | **Extracted from HTML/CSS** - Found in WebFetch analysis |
| 📷🔍 | **Confirmed by both** - Cross-validated from visual and HTML |
| 🔮 | **Inferred from style** - Derived from [Primary Style] conventions |
| ✏️ | **User-specified** - Explicitly provided by user during analysis |
| ⚠️ | **Needs verification** - Estimated, verify against actual implementation |

> **Coverage Summary:**
> - URLs analyzed: [N]
> - Page types covered: [list]
> - Viewports captured: Desktop only / Multiple
> - States visible: [list what was actually captured]
> - Inferred sections: [list what was inferred]

## Design Direction
- **Primary Style:** [Style from database] 📷🔍
- **Secondary Influences:** [Other styles] 📷🔍
- **Inspiration:** [URLs analyzed]
- **Mood:** [2-3 descriptive words] 📷

## Style Reference
> [Brief description of the primary style from the database, so future readers understand the intent]

## Source Analysis
| URL | Page Type | Analysis Method | Key Extractions | Source |
|-----|-----------|-----------------|-----------------|--------|
| [url] | [type] | WebFetch + Visual | [what was extracted] | 📷🔍 |
| ... | | | | |

## Visual References
Screenshots (1 per page) available at: `{BASE_DIR}/screenshots/`
| Page | Screenshot Path |
|------|-----------------|
| Main | {BASE_DIR}/screenshots/main.png |
| Docs | {BASE_DIR}/screenshots/docs.png |
| [page] | {BASE_DIR}/screenshots/[slug].png |

## Color System 📷🔍
| Token | Light Mode | Dark Mode | Usage | Source |
|-------|------------|-----------|-------|--------|
| --color-primary | #xxx | #xxx | Buttons, links, accents | 📷🔍 |
| --color-secondary | #xxx | #xxx | Secondary actions | 📷🔍 |
| --color-accent | #xxx | #xxx | Highlights, badges | 📷🔍 |
| --color-background | #xxx | #xxx | Page background | 🔍 |
| --color-surface | #xxx | #xxx | Cards, elevated elements | 📷🔍 |
| --color-text | #xxx | #xxx | Body text | 📷🔍 |
| --color-text-muted | #xxx | #xxx | Secondary text | 📷 |
| --color-border | #xxx | #xxx | Dividers, input borders | 📷🔍 |
| --color-error | #xxx | #xxx | Error states | 🔍/🔮 |
| --color-warning | #xxx | #xxx | Warning states | 🔍/🔮 |
| --color-success | #xxx | #xxx | Success states | 🔍/🔮 |
| --color-info | #xxx | #xxx | Info states | 🔍/🔮 |

> **Note:** Status colors marked 🔮 are inferred if not visible on analyzed pages.

## Typography
```css
--font-heading: '[Font]', [fallback];
--font-body: '[Font]', [fallback];
--font-mono: '[Font]', monospace;

--text-xs: 0.75rem;    /* 12px */
--text-sm: 0.875rem;   /* 14px */
--text-base: 1rem;     /* 16px */
--text-lg: 1.125rem;   /* 18px */
--text-xl: 1.25rem;    /* 20px */
--text-2xl: 1.5rem;    /* 24px */
--text-3xl: 1.875rem;  /* 30px */
--text-4xl: 2.25rem;   /* 36px */

--font-weight-normal: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
--font-weight-bold: 700;

--line-height-tight: 1.25;
--line-height-normal: 1.5;
--line-height-relaxed: 1.75;
```

## Spacing & Layout
```css
--radius-none: 0;
--radius-sm: [x]px;
--radius-md: [x]px;
--radius-lg: [x]px;
--radius-xl: [x]px;
--radius-full: 9999px;

--spacing-1: 0.25rem;  /* 4px */
--spacing-2: 0.5rem;   /* 8px */
--spacing-3: 0.75rem;  /* 12px */
--spacing-4: 1rem;     /* 16px */
--spacing-6: 1.5rem;   /* 24px */
--spacing-8: 2rem;     /* 32px */
--spacing-12: 3rem;    /* 48px */
--spacing-16: 4rem;    /* 64px */

--container-sm: 640px;
--container-md: 768px;
--container-lg: 1024px;
--container-xl: 1280px;
```

## Shadows
```css
--shadow-sm: [value];
--shadow-md: [value];
--shadow-lg: [value];
--shadow-xl: [value];
--shadow-inner: [value];
```

## Component Library
- **Framework:** Nuxt 3
- **CSS:** [Tailwind / UnoCSS / custom]
- **Components:** [Library choice]
- **Icons:** [Icon library]
- **Fonts Source:** [Google Fonts / Adobe / Self-hosted]

## Component Specifications

### Buttons
- Border radius: [value]
- Padding: [value]
- Font weight: [value]
- Text transform: [none/uppercase]
- Variants: [primary, secondary, ghost, destructive]
- Hover: [behavior]
- Active/Press: [behavior]
- Disabled: [appearance]
- Focus: [ring style]
- **Visual reference:** [screenshot path]

### Cards
- Background: [solid/gradient/blur]
- Border: [none/subtle/prominent]
- Border radius: [value]
- Shadow: [style]
- Hover: [behavior]
- Padding: [value]
- **Visual reference:** [screenshot path]

### Forms
- Input style: [bordered/underline/filled]
- Label position: [above/floating/inline]
- Border radius: [value]
- Error display: [below/tooltip/border-color]
- Focus state: [ring/border/glow]
- Placeholder style: [color, italic?]
- **Visual reference:** [screenshot path]

### Tables
- Header style: [sticky/scrollable, background]
- Row hover: [highlight color/none]
- Row striping: [yes/no]
- Borders: [full/horizontal/none]
- Density: [compact/comfortable]
- Cell padding: [value]

### Navigation
- Primary: [sidebar/topbar/command-palette]
- Sidebar width: [collapsed/expanded values]
- Mobile: [drawer/bottom-bar/hamburger]
- Active indicator: [background/border/icon]
- Hover state: [description]
- **Visual reference:** [screenshot path]

### Modals/Dialogs
- Overlay: [color, opacity]
- Border radius: [value]
- Animation: [fade/scale/slide]
- Close button: [position, style]

### Feedback & States 📷/🔍/🔮
- Loading: [skeleton/spinner/shimmer] [📷 if visible / 🔮 if inferred]
- Empty: [illustration/text/CTA] [📷 if visible / 🔮 if inferred]
- Error: [toast/inline/modal] [📷 if visible / 🔮 if inferred]
- Success: [toast/inline/redirect] [📷 if visible / 🔮 if inferred]
- Toast position: [top-right/bottom-right/top-center/bottom-center] [📷/🔮]

---

## 🔮 Responsive Design (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED** based on style classification. Screenshots captured desktop viewport only.
> Verify these values match your actual requirements.

### Breakpoints
| Name | Value | Layout Changes | Source |
|------|-------|----------------|--------|
| sm (Mobile) | [X]px | [Stacked layouts, hidden sidebar, etc.] | 🔮 |
| md (Tablet) | [X]px | [Sidebar collapses, grid adjusts] | 🔮 |
| lg (Desktop) | [X]px | [Full layout visible] | 🔮 |
| xl (Wide) | [X]px | [Max-width containers, centered] | 🔮 |

### Responsive Behavior
- **Sidebar:** [Behavior at each breakpoint] 🔮
- **Navigation:** [How nav changes] 🔮
- **Grid:** [Column changes] 🔮
- **Typography:** [Size scaling] 🔮
- **Spacing:** [Density changes] 🔮

---

## 🔮 Loading States (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED**. No loading states were captured during analysis.

### Primary Loading Pattern
- **Method:** [Skeleton / Spinner / Shimmer / Progress bar] 🔮
- **Style:** [Description from style table] 🔮

### Skeleton Loaders 🔮
```css
/* Skeleton base */
.skeleton {
  background: var(--color-surface);
  animation: [shimmer/pulse] [duration] ease-in-out infinite;
}
```
- Shape: [Matches content shape / Rounded rectangles / Circles for avatars]
- Animation: [Shimmer gradient / Pulse opacity / None]
- Duration: [0.8s-1.5s typical]

### Spinner Style 🔮
- Type: [Circular / Dots / Line / Brand-specific]
- Size: [sm: 16px, md: 24px, lg: 32px]
- Color: [Primary / Muted / Contextual]
- Placement: [Centered / Inline / Button replacement]

### Loading UX Patterns 🔮
- **Page load:** [Full skeleton / Spinner overlay / Progressive]
- **Button loading:** [Spinner replaces text / Spinner beside text / Disabled + spinner]
- **Infinite scroll:** [Bottom spinner / Skeleton cards / "Load more" button]
- **Form submit:** [Button spinner / Overlay / Inline]

---

## 🔮 Empty States (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED**. No empty states were visible on analyzed pages.

### Empty State Pattern
- **Illustration:** [None / Icon / Custom illustration / Lottie animation] 🔮
- **Copy style:** [Friendly / Technical / Action-oriented] 🔮
- **CTA approach:** [Primary button / Ghost button / Text link / None] 🔮

### Empty State Template 🔮
```
┌─────────────────────────────────────┐
│                                     │
│         [Icon/Illustration]         │
│                                     │
│          [Primary message]          │
│       [Secondary description]       │
│                                     │
│           [ CTA Button ]            │
│                                     │
└─────────────────────────────────────┘
```

### Context-Specific Empty States 🔮
| Context | Message Tone | CTA | Icon |
|---------|--------------|-----|------|
| No search results | Helpful | Modify search | Search icon |
| Empty list | Encouraging | Create first item | Plus/Add icon |
| No data | Informative | Connect data source | Data icon |
| No permissions | Explanatory | Request access | Lock icon |

---

## 🔮 Error States (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED**. No error states were visible on analyzed pages.

### Error Display Methods 🔮
- **Toast notifications:** [Position, duration, style]
- **Inline errors:** [Below field / Tooltip / Border color change]
- **Page-level errors:** [Banner / Modal / Dedicated page]
- **Field validation:** [On blur / On submit / Real-time]

### Error Severity Levels 🔮
| Level | Color | Icon | Display | Auto-dismiss |
|-------|-------|------|---------|--------------|
| Info | --color-info | Info circle | Toast | Yes, 5s |
| Warning | --color-warning | Warning triangle | Toast/Inline | No |
| Error | --color-error | X circle | Inline + Toast | No |
| Critical | --color-error | Alert | Modal | No |

### Error Recovery UX 🔮
- **Retry mechanism:** [Button / Auto-retry / Manual refresh]
- **Error messages:** [Technical / User-friendly / Both with details toggle]
- **Undo support:** [Toast with undo / No undo]

### Toast Configuration 🔮
```css
--toast-position: [top-right / bottom-right / top-center / bottom-center];
--toast-duration: [3000ms / 5000ms / persistent];
--toast-max-visible: [3 / 5 / unlimited];
--toast-animation: [slide / fade / scale];
```

---

## 🔮 Mobile Patterns (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED**. Analysis captured desktop viewport only.

### Mobile Navigation 🔮
- **Primary pattern:** [Bottom nav / Hamburger drawer / Tab bar]
- **Hamburger menu:** [Slide from left / Slide from right / Full overlay]
- **Bottom navigation:** [Yes/No, number of items]
- **Gesture support:** [Swipe to open menu / Swipe between tabs / Pull to refresh]

### Mobile Layout Adjustments 🔮
- **Sidebar:** [Hidden / Bottom sheet / Collapsible]
- **Tables:** [Horizontal scroll / Card view / Responsive columns]
- **Forms:** [Full width inputs / Stacked labels]
- **Modals:** [Full screen / Bottom sheet / Centered]
- **Navigation:** [Sticky header / Hide on scroll / Always visible]

### Touch Targets 🔮
- **Minimum size:** [44px / 48px] (following [Primary Style] conventions)
- **Spacing between targets:** [8px minimum]
- **Touch feedback:** [Ripple / Highlight / Scale]

### Mobile-Specific Components 🔮
- **Action sheets:** [iOS-style / Material / Custom]
- **Pull to refresh:** [Spinner / Custom animation]
- **Swipe actions:** [Delete / Archive / Custom actions]
- **Floating action button:** [Yes/No, position]

---

## 🔮 Accessibility Guidelines (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED** based on style conventions and WCAG standards.

### Color & Contrast 🔮
- **Minimum contrast ratio:** [4.5:1 AA / 7:1 AAA]
- **Large text contrast:** [3:1 minimum]
- **Non-text contrast:** [3:1 for UI components]
- **Don't rely on color alone:** [Use icons, patterns, or text labels]

### Focus Management 🔮
```css
/* Focus ring style for [Primary Style] */
:focus-visible {
  outline: [2px solid var(--color-primary)];
  outline-offset: [2px];
  border-radius: [var(--radius-sm)];
}

/* High contrast mode */
@media (prefers-contrast: high) {
  :focus-visible {
    outline-width: 3px;
  }
}
```

### Motion & Animation 🔮
```css
/* Respect reduced motion preference */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Screen Reader Support 🔮
- **ARIA landmarks:** [header, nav, main, footer, aside]
- **Live regions:** [For dynamic content updates]
- **Skip links:** [Skip to main content]
- **Form labels:** [Associated labels for all inputs]
- **Image alt text:** [Descriptive for content, empty for decorative]

### Keyboard Navigation 🔮
- **Tab order:** [Logical, follows visual layout]
- **Focus trapping:** [In modals and dropdowns]
- **Escape key:** [Closes modals, dropdowns, menus]
- **Arrow keys:** [Navigate within components]
- **Enter/Space:** [Activate buttons and links]

### WCAG Checklist 🔮
| Criterion | Level | Status | Notes |
|-----------|-------|--------|-------|
| 1.1.1 Non-text Content | A | 🔮 | Provide alt text |
| 1.4.3 Contrast (Minimum) | AA | 🔮 | 4.5:1 ratio |
| 2.1.1 Keyboard | A | 🔮 | All interactive elements |
| 2.4.7 Focus Visible | AA | 🔮 | Clear focus indicators |
| 2.5.5 Target Size | AAA | 🔮 | 44x44px minimum |

---

## 🔮 Page Layout Patterns (Inferred from [Primary Style])

> ⚠️ This section is **INFERRED**. Layout patterns derived from style classification.

### Default Page Structure 🔮
```
┌────────────────────────────────────────────────────────┐
│ Header [fixed/sticky/static]                           │
├──────────┬─────────────────────────────────────────────┤
│ Sidebar  │ Main Content                                │
│ [width]  │ [max-width: Xpx, centered]                  │
│          │                                             │
│          │                                             │
│          │                                             │
└──────────┴─────────────────────────────────────────────┘
```

### Layout Specifications 🔮
- **Content max-width:** [from style table]
- **Sidebar width:** [collapsed: Xpx, expanded: Xpx]
- **Header height:** [estimate based on style]
- **Grid system:** [from style table]
- **Gutter width:** [16px / 24px / 32px]

---

## Micro-Interactions 📷/🔮
- Page transitions: [slide/fade/none]
- Element enter: [fade-up/scale/none]
- Button press: [scale-down/darken/none]
- Hover timing: [instant/150ms/300ms]
- Default easing: [ease-out/ease-in-out/spring]

## Anti-Patterns (DO NOT USE)
Based on **[Primary Style]**, avoid:
- [Style-specific anti-patterns]
- [User-specified anti-patterns]

## Reference URLs
| URL | What to reference | Screenshot |
|-----|-------------------|------------|
| [url] | [specific elements] | [path] |
| ... | | |

## Analysis Artifacts
All analysis files preserved at: `{BASE_DIR}/`
- Screenshots: `{BASE_DIR}/screenshots/`
- HTML reports: `{BASE_DIR}/html/`
- Visual reports: `{BASE_DIR}/reports/`

## Specification Confidence Summary

### What Was Extracted (📷🔍)
| Category | Confidence | Source | Notes |
|----------|------------|--------|-------|
| Colors | High | 📷🔍 | Cross-validated from HTML + screenshots |
| Typography | High | 🔍 | Font families from Google Fonts links |
| Spacing/radius | Medium | 📷🔍 | From Tailwind classes + visual |
| Component patterns | High | 📷🔍 | Observed in both sources |
| Layout structure | High | 📷 | From desktop screenshots |
| Framework detection | High | 🔍 | From HTML class patterns |

### What Was Inferred (🔮)
| Category | Based On | Override Recommended |
|----------|----------|---------------------|
| Responsive breakpoints | [Primary Style] conventions | If you have specific requirements |
| Loading states | [Primary Style] patterns | If you have designs for these |
| Empty states | [Primary Style] patterns | If you have designs for these |
| Error states | [Primary Style] patterns | If you have designs for these |
| Mobile patterns | [Primary Style] conventions | If you have mobile designs |
| Accessibility | WCAG + [Primary Style] | Review against your requirements |

### Recommended Next Steps
1. **Verify responsive behavior** - Test actual site at different viewports if possible
2. **Capture additional states** - Request analysis of pages showing loading, empty, or error states
3. **Mobile analysis** - Request mobile viewport screenshots if mobile is critical
4. **Review inferred sections** - All 🔮 sections are suggestions based on style conventions

## Limitations of URL-Based Analysis

### What This Analysis CAN Extract
- Exact colors from CSS/Tailwind classes (🔍)
- Font families from font links and CSS (🔍)
- Component patterns from HTML structure (🔍)
- Visual appearance at captured viewport (📷)
- Framework and library detection (🔍)
- Cross-validated styling from both sources (📷🔍)

### What This Analysis CANNOT Extract
- **Responsive behavior:** Only desktop viewport typically captured
- **Interactive states:** Hover, focus, active states (unless captured during interaction)
- **Loading states:** Unless page happened to be loading during capture
- **Empty/error states:** Unless visible on analyzed pages
- **Mobile navigation:** Unless mobile viewport specifically requested
- **Accessibility details:** Focus rings, screen reader behavior, motion preferences
- **Animation timing:** Static screenshots don't capture motion

### How Inference Fills the Gaps
When analysis doesn't capture certain behaviors, this specification uses **style-based inference**:
1. The analyzed pages are classified against known UI styles (e.g., "Linear-Style", "Notion-Style")
2. Missing behaviors are filled with conventions typical of that style
3. All inferred content is marked with 🔮 so you know it needs verification
4. You can override any inferred value with your actual requirements

### Advantages Over Image-Only Analysis
- **Exact color values** from CSS (not estimated)
- **Font family names** from font links (not guessed)
- **Framework detection** for config file generation
- **Dark mode colors** from CSS variables (if defined)
- **Cross-validation** increases confidence

## Notes
[Any additional context or decisions made during specification]
```

### Step 8: Handle New Style Additions

If the user confirms a new style should be added, tell them:

"To add **[New Style Name]** to the reference database, add this entry to `~/.claude/commands/ui/create-style-from-url.md` in the appropriate category table:

```markdown
| **[New Style Name]** | [Key characteristics] | [Example products] |
```

I recommend adding it to the **[suggested category]** section."

### Step 9: Save Style Guide and Offer Next Steps

**First, always ask:**
- "Should I save this style specification as `{BASE_DIR}/STYLE_GUIDE.md`? This will serve as the reference for creating new page specifications."

**Then, based on the detected libraries/tools, offer to create relevant config files:**

| Detected Technology | Offer to Create |
|---------------------|-----------------|
| Tailwind CSS | `{BASE_DIR}/tailwind.config.ts` with colors, fonts, spacing, border-radius presets |
| UnoCSS | `{BASE_DIR}/uno.config.ts` with theme tokens and shortcuts |
| CSS Variables | `{BASE_DIR}/variables.css` with all design tokens |
| shadcn/ui | `{BASE_DIR}/components.json` with style presets |
| Theme (dark/light) | `{BASE_DIR}/theme.ts` with theme configuration |

**Ask the user which additional files they want:**
- "Based on the analysis, I detected **[libraries/tools]**. Would you like me to generate any of these config files?"
  - `tailwind.config.ts` - Tailwind theme with extracted colors, fonts, spacing, and border-radius
  - `variables.css` - CSS custom properties for all design tokens
  - `theme.ts` - TypeScript theme object for CSS-in-JS solutions
  - `[other relevant configs based on detected stack]`

**Additional options:**
- "Should I create example components demonstrating this style?"
- "Should I move the screenshots to a different location (e.g., `docs/assets/`)?"
- "Do you want to keep all analysis artifacts in `{BASE_DIR}/` or clean up intermediate files?"

---

## Subagent Execution Reference

### WebFetch Subagent Template

```
subagent_type: "general-purpose"
prompt: |
  Use WebFetch to analyze {URL} for UI style extraction.

  Your task:
  1. Fetch the URL content
  2. Extract all CSS classes, inline styles, and framework indicators
  3. Identify colors, typography, spacing patterns
  4. Detect frameworks (Tailwind, Bootstrap, etc.)
  5. Save findings to {BASE_DIR}/html/{slug}.md

  Be thorough - extract every style-related class and pattern you find.
```

### agent-browser Subagent Template

```
subagent_type: "general-purpose"
prompt: |
  Use the agent-browser skill to visually analyze {URL}.

  Your task:
  1. Navigate to the URL using agent-browser
  2. WAIT for the page to be COMPLETELY loaded (network idle, all images loaded)
  3. Take ONE full-page screenshot using this command:
     agent-browser screenshot --full {BASE_DIR}/screenshots/{slug}.png
  4. Analyze colors, typography, spacing, shadows from what you SEE in the screenshot
  5. Save visual analysis to {BASE_DIR}/reports/{slug}-visual.md

  Only ONE screenshot per page. The --full flag captures the entire scrollable page.
```

### Parallel Execution Pattern

When you have URLs to analyze, ALWAYS launch subagents in parallel:

```
For URLs: [main, /docs, /pricing]

Launch in ONE message with 6 Task tool calls:
1. Task: WebFetch for main
2. Task: agent-browser for main
3. Task: WebFetch for /docs
4. Task: agent-browser for /docs
5. Task: WebFetch for /pricing
6. Task: agent-browser for /pricing
```

This maximizes efficiency by running all analyses concurrently.

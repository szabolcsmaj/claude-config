# UI Style Specification Generator

You are helping the user create a comprehensive UI style specification by analyzing URLs using **dual analysis**: text-based HTML extraction AND visual screenshot analysis.

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
- Extract ALL internal links from the main page's HTML
- Look for navigation menus, footers, and sitemap links
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

### Step 1.5: MANDATORY - Print URL List Before Analysis

**⚠️ CRITICAL: You MUST print the complete URL list and get user confirmation BEFORE launching any analysis subagents.**

After discovering URLs, ALWAYS output this to the user:

```markdown
═══════════════════════════════════════════════════════════════════
                    📋 URLs TO BE ANALYZED
═══════════════════════════════════════════════════════════════════

Base Domain: [extracted domain]
Total URLs: [count]

## URLs for Analysis:

| # | URL | Page Type | Analysis |
|---|-----|-----------|----------|
| 1 | [full URL] | Marketing | WebFetch + Visual |
| 2 | [full URL] | Documentation | WebFetch + Visual |
| 3 | [full URL] | Pricing | WebFetch + Visual |
| 4 | [full URL] | Blog | WebFetch + Visual |
| ... | ... | ... | ... |

## Analysis Plan:
- WebFetch subagents: [count] (1 per URL)
- agent-browser subagents: [count] (1 per URL, 1 screenshot each)
- Total subagents: [count × 2]
- Total screenshots: [count] (1 full-page screenshot per URL)
- Screenshots will be saved to: {BASE_DIR}/screenshots/

═══════════════════════════════════════════════════════════════════
```

**Then ASK the user:**
- "I found [N] URLs to analyze. Should I proceed with all of them?"
- "Would you like to add any URLs to this list?"
- "Would you like to remove any URLs from this list?"
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

After gathering all input, produce a complete specification file:

```markdown
# UI Style Specification: [Project Name]

## Design Direction
- **Primary Style:** [Style from database]
- **Secondary Influences:** [Other styles]
- **Inspiration:** [URLs analyzed]
- **Mood:** [2-3 descriptive words]

## Style Reference
> [Brief description of the primary style from the database, so future readers understand the intent]

## Source Analysis
| URL | Page Type | Analysis Method | Key Extractions |
|-----|-----------|-----------------|-----------------|
| [url] | [type] | WebFetch + Visual | [what was extracted] |
| ... | | | |

## Visual References
Screenshots (1 per page) available at: `{BASE_DIR}/screenshots/`
| Page | Screenshot Path |
|------|-----------------|
| Main | {BASE_DIR}/screenshots/main.png |
| Docs | {BASE_DIR}/screenshots/docs.png |
| [page] | {BASE_DIR}/screenshots/[slug].png |

## Color System
| Token | Light Mode | Dark Mode | Source | Usage |
|-------|------------|-----------|--------|-------|
| --color-primary | #xxx | #xxx | [WebFetch/Visual/Both] | Buttons, links, accents |
| --color-secondary | #xxx | #xxx | [source] | Secondary actions |
| --color-accent | #xxx | #xxx | [source] | Highlights, badges |
| --color-background | #xxx | #xxx | [source] | Page background |
| --color-surface | #xxx | #xxx | [source] | Cards, elevated elements |
| --color-text | #xxx | #xxx | [source] | Body text |
| --color-text-muted | #xxx | #xxx | [source] | Secondary text |
| --color-border | #xxx | #xxx | [source] | Dividers, input borders |
| --color-error | #xxx | #xxx | [source] | Error states |
| --color-warning | #xxx | #xxx | [source] | Warning states |
| --color-success | #xxx | #xxx | [source] | Success states |
| --color-info | #xxx | #xxx | [source] | Info states |

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

### Feedback & States
- Loading: [skeleton/spinner/shimmer]
- Empty: [illustration/text/CTA]
- Error: [toast/inline/modal]
- Success: [toast/inline/redirect]
- Toast position: [top-right/bottom-right/top-center/bottom-center]

## Micro-Interactions
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

### Step 9: Offer Next Steps

Ask the user:
- "Should I save this specification to a file in your project? (e.g., `docs/ui-style-spec.md` or `UI_STYLE.md`)"
- "Want me to generate a Tailwind config (`tailwind.config.ts`) based on these values?"
- "Should I create a CSS variables file for these tokens?"
- "Should I create example components demonstrating this style?"
- "Want me to keep the `{BASE_DIR}/` directory or clean it up after generating the spec?"
- "Should I move the screenshots to a different location (e.g., `docs/assets/`)?"

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

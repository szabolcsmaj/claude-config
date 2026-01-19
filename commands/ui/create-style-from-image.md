# UI Style Specification Generator (Image-Based)

You are helping the user create a comprehensive UI style specification by analyzing screenshots.

## Input

Screenshot path(s): $ARGUMENTS

---

## UI Design Styles Reference Database

Use this reference to classify analyzed screenshots. Match against one or more styles, or identify if it's a new style not in this list.

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

Before starting analysis, create the output directory for organized results:

**Directory Naming Convention:**
1. Examine the screenshot(s) to infer what the page/product is about
2. Create a descriptive slug name (e.g., "dashboard", "ecommerce-checkout", "saas-landing", "admin-panel")
3. Convert ALL non-alphanumeric characters to `-`
4. Create directory: `style-analysis-screenshot-{inferred-name}`

**Examples:**
| Screenshot Content | Inferred Name | Output Directory |
|--------------------|---------------|------------------|
| E-commerce product page | `ecommerce-product` | `./style-analysis-screenshot-ecommerce-product/` |
| SaaS dashboard with charts | `saas-dashboard` | `./style-analysis-screenshot-saas-dashboard/` |
| Blog article layout | `blog-article` | `./style-analysis-screenshot-blog-article/` |
| Mobile banking app | `mobile-banking` | `./style-analysis-screenshot-mobile-banking/` |
| Multiple mixed screenshots | `ui-reference` | `./style-analysis-screenshot-ui-reference/` |

**Create the directory structure:**
```bash
# Replace {inferred-name} with the actual slugified name
mkdir -p ./style-analysis-screenshot-{inferred-name}/screenshots
mkdir -p ./style-analysis-screenshot-{inferred-name}/reports
```

**Copy source screenshots to the directory:**
```bash
# Copy all provided screenshots to the screenshots folder for reference
cp [provided-screenshot-paths] ./style-analysis-screenshot-{inferred-name}/screenshots/
```

**Store the base path** for use throughout the analysis:
```
BASE_DIR="./style-analysis-screenshot-{inferred-name}"
```

### Step 1: Classify Each Screenshot

Before deep analysis, determine what type of page each screenshot shows:

**Page Type Classification:**
| Type | Characteristics | What It Reveals |
|------|-----------------|-----------------|
| **Marketing/Landing** | Hero sections, CTAs, feature showcases, testimonials | Brand colors, marketing typography, illustration style |
| **Documentation** | Sidebar nav, code blocks, search, content-heavy | Reading typography, code styling, navigation patterns |
| **Blog/Content** | Article layout, author info, related posts | Editorial style, image treatment, content typography |
| **Product/App UI** | Dashboard, forms, tables, authenticated views | Actual component styles, data density, interaction patterns |
| **Pricing/Comparison** | Tables, feature lists, plan cards | Card styles, table design, CTA treatment |
| **Login/Auth** | Forms, social buttons, minimal layout | Form styling, button variants, error states |
| **Changelog/Updates** | Timeline, version numbers, categorized entries | List styles, badge/tag design, date formatting |
| **Mobile View** | Responsive layout, touch targets, mobile navigation | Mobile-specific patterns, adaptive design choices |

**IMPORTANT:** Marketing pages and product UIs often have DIFFERENT design systems. Note which type each screenshot represents and ask the user which they want to emulate.

### Step 1: Visual Inventory

Use the Read tool to examine each screenshot. For each image, catalog:

```markdown
## Screenshot Analysis: [filename]

### Page Type: [Classification from Step 0]

### Visual Elements Identified:
- [ ] Navigation (type, position)
- [ ] Headers/Hero sections
- [ ] Cards/Containers
- [ ] Buttons (variants visible)
- [ ] Forms/Inputs
- [ ] Tables/Lists
- [ ] Icons (style: outline/filled/duotone)
- [ ] Images/Illustrations
- [ ] Footer
```

Report what screenshots were provided:
```markdown
## Screenshots Provided

| # | Filename | Page Type | Key Elements |
|---|----------|-----------|--------------|
| 1 | [name] | [type] | [brief list] |
| 2 | [name] | [type] | [brief list] |
...
```

Ask the user:
- "I see these screenshots. Do they represent the same product/site or different references?"
- "Is there a specific page type you care most about? (e.g., 'I want my app to look like the dashboard screenshot, not the marketing one')"
- "Do you have additional screenshots I should analyze?"

**Limit: Analyze maximum 8 screenshots total to keep focused.**

### Step 2: Visual Extraction

For each screenshot, extract by visual inspection and **save findings to `{BASE_DIR}/reports/[screenshot-slug]-analysis.md`**:

**Colors (estimate hex values from visual inspection):**
- [ ] Background colors (primary, secondary)
- [ ] Text colors (headings, body, muted)
- [ ] Primary accent color
- [ ] Secondary accent color
- [ ] Border/divider colors
- [ ] Button colors (primary, secondary, destructive)
- [ ] Status colors (success, warning, error, info) if visible

**Typography (describe what you observe):**
- [ ] Heading font style (serif/sans-serif/monospace, weight)
- [ ] Body font style
- [ ] Approximate size hierarchy (large/medium/small headings)
- [ ] Line height (tight/normal/relaxed)
- [ ] Letter spacing (tight/normal/wide)

**Spacing & Layout:**
- [ ] Overall density (spacious/moderate/compact)
- [ ] Border radius (none/subtle/medium/rounded/pill)
- [ ] Shadow style (none/subtle/medium/dramatic)
- [ ] Grid system (cards/lists/bento/single-column)
- [ ] Container width (narrow/medium/wide/full)

**Component Patterns:**
- [ ] Button styles (solid/outline/ghost, rounded/square)
- [ ] Card styles (bordered/shadowed/flat)
- [ ] Input styles (bordered/underlined/filled)
- [ ] Navigation style (sidebar/topbar/tabs)
- [ ] Icon style (outline/filled/duotone)

**Page-Type Specific Extraction:**
- **Docs screenshots:** Sidebar width, code block styling, heading hierarchy, search UI
- **Pricing screenshots:** Card layout, feature list styling, CTA button variants
- **Blog screenshots:** Article width, image sizing, author components
- **Login screenshots:** Form field styling, button styling, social auth buttons
- **Dashboard screenshots:** Widget/card density, table styling, navigation patterns

### Step 3: Cross-Screenshot Consistency Analysis

If multiple screenshots were provided, identify:

```markdown
## Design System Consistency Report

### Consistent Across All Screenshots:
- Colors: [which colors appear consistently]
- Typography: [which font styles appear everywhere]
- Components: [which components look the same]

### Variations by Page Type:
| Element | Marketing | Docs | App/Dashboard |
|---------|-----------|------|---------------|
| Heading style | [x] | [y] | [z] |
| Spacing density | Spacious | Moderate | Compact |
| Border radius | 16px | 8px | 4px |

### Notable Inconsistencies:
- [List any style conflicts between screenshots]

### Recommendation:
"The [page type] screenshots best represent the style you likely want for your app because [reason]."
```

### Step 4: Match Against Style Reference Database

**CRITICAL STEP:** Compare findings against the UI Design Styles Reference Database above.

Determine:
1. **Primary Style Match:** Which style from the database best describes this design? (Pick 1)
2. **Secondary Style Influences:** What other styles are present? (Pick 0-3)
3. **Confidence Level:** How well does it match? (Strong match / Partial match / Weak match)
4. **Style Varies by Screenshot?** Note if different screenshots show different styles.

**If NO style matches well:**
- Describe the unique characteristics that don't fit existing categories
- Propose a NEW style name and definition
- Ask: "This appears to be a style not in my reference database. I'd call it **[Proposed Name]** characterized by [characteristics]. Should I add this to the style reference for future use?"

Present the style matching:

```markdown
## Style Classification

### Primary Style: [Style Name]
**Confidence:** [Strong/Partial/Weak]
**Best represented in:** [which screenshot]
**Matching characteristics:**
- [bullet points of what matches]

### Secondary Influences:
- **[Style Name]:** [which elements match, in which screenshots]
- **[Style Name]:** [which elements match, in which screenshots]

### Style by Screenshot:
| Screenshot | Primary Style | Notes |
|------------|---------------|-------|
| [filename] | [style] | [notes] |
| [filename] | [style] | [notes] |

### Deviations from Standard:
- [What differs from the matched style's typical implementation]
```

### Step 5: Present Consolidated Findings

Merge findings from all analyzed screenshots:

```markdown
## Extracted Style Specification

### Screenshots Analyzed
1. [filename] - [Page Type] - [Primary style found]
2. [filename] - [Page Type] - [Primary style found]
...

### Style Classification
[From Step 4]

### Colors (Estimated from Visual Inspection)
| Role | Estimated Hex | Found In | Usage |
|------|---------------|----------|-------|
| Primary | #xxx | All screenshots | Buttons, links |
| Secondary | #xxx | Marketing only | CTAs |
| ... | | | |

**Note:** These colors are estimated from visual inspection. For exact values, inspect the actual CSS or design files.

### Typography (Observed)
- Headings: [Serif/Sans-serif], appears [bold/semibold], [size observations]
- Body: [Serif/Sans-serif], [weight observations], [size observations]
- Mono/Code: [If visible in screenshots]

**Note:** Font families cannot be definitively identified from screenshots. These are visual descriptions.

### Measurements (Estimated)
- Border radius: [none/small/medium/large/pill]
- Base spacing: [tight/normal/spacious]
- Container max-width: [narrow/medium/wide/full-width]
- Shadows: [none/subtle/medium/dramatic]

### Layout Patterns by Page Type
- Marketing: [description]
- Docs: [description]
- App: [description]
```

### Step 6: Interactive Clarification

After presenting findings, ASK the user:

1. **Page Type Preference:**
   - "Your screenshots show different page types with varying styles. Which do you want to base your spec on?"
   - "Should I create separate specs for marketing vs. app pages?"

2. **Style Confirmation:**
   - "I classified this as **[Style]** with **[Secondary]** influences. Does that match your intent?"
   - If new style proposed: "Should I add **[Proposed Style]** to the reference database?"

3. **Cannot Detect From Screenshots (MUST ASK):**
   - "I cannot detect the exact font families from screenshots. What fonts should we use?"
     - Headings: [Suggest based on visual style]
     - Body: [Suggest based on visual style]
     - Mono: [Suggest based on visual style]
   - "What icon library do you want? (Lucide, Heroicons, Phosphor, Tabler, custom SVGs)"
   - "What component library? For Nuxt: Nuxt UI, shadcn-vue, Radix Vue, PrimeVue, Headless UI"
   - "CSS framework preference? (Tailwind, UnoCSS, custom)"

4. **Exact Values (if needed):**
   - "I estimated colors from the screenshots. Do you have exact hex values, or should I use my estimates?"
   - "Border radius appears [description]. What exact pixel values do you want?"

5. **Contradictions or Choices:**
   - "I see both sharp (one screenshot) and rounded (another) corners. Which do you prefer?"
   - "I see both card-based and list layouts. What's your primary content display preference?"

6. **Deeper Style Questions:**
   - "How should loading states appear? (Skeletons / Spinners / Shimmer / None)"
   - "What's your button interaction style? (Scale / Color shift / Shadow lift / Ripple)"
   - "Empty states: Illustrated / Minimal text / Call-to-action focused?"
   - "Form style: Floating labels / Stacked / Inline / Bordered inputs?"
   - "Navigation pattern: Sidebar / Top bar / Command palette / Breadcrumbs?"

7. **Additional References:**
   - "Do you have additional screenshots for specific components? (e.g., tables, modals, forms)"
   - "Any other products whose style you'd like to reference?"

8. **Anti-Patterns:**
   - "What should this NOT look like? Any styles from the reference to explicitly avoid?"

### Step 7: Generate Final Specification

After gathering all input, produce a complete specification file:

```markdown
# UI Style Specification: [Project Name]

## Design Direction
- **Primary Style:** [Style from database]
- **Secondary Influences:** [Other styles]
- **Inspiration:** Screenshots analyzed (see Source Analysis)
- **Mood:** [2-3 descriptive words]

## Style Reference
> [Brief description of the primary style from the database, so future readers understand the intent]

## Source Analysis
| Screenshot | Path | Page Type | Key Extractions |
|------------|------|-----------|-----------------|
| [filename] | `{BASE_DIR}/screenshots/[filename]` | [type] | [what was extracted] |
| ... | | | |

## Color System
| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| --color-primary | #xxx | #xxx | Buttons, links, accents |
| --color-secondary | #xxx | #xxx | Secondary actions |
| --color-accent | #xxx | #xxx | Highlights, badges |
| --color-background | #xxx | #xxx | Page background |
| --color-surface | #xxx | #xxx | Cards, elevated elements |
| --color-text | #xxx | #xxx | Body text |
| --color-text-muted | #xxx | #xxx | Secondary text |
| --color-border | #xxx | #xxx | Dividers, input borders |
| --color-error | #xxx | #xxx | Error states |
| --color-warning | #xxx | #xxx | Warning states |
| --color-success | #xxx | #xxx | Success states |
| --color-info | #xxx | #xxx | Info states |

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

### Cards
- Background: [solid/gradient/blur]
- Border: [none/subtle/prominent]
- Border radius: [value]
- Shadow: [style]
- Hover: [behavior]
- Padding: [value]

### Forms
- Input style: [bordered/underline/filled]
- Label position: [above/floating/inline]
- Border radius: [value]
- Error display: [below/tooltip/border-color]
- Focus state: [ring/border/glow]
- Placeholder style: [color, italic?]

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

## Reference Screenshots
| Filename | Path | What to reference |
|----------|------|-------------------|
| [name] | `{BASE_DIR}/screenshots/[name]` | [specific elements] |
| ... | | |

## Analysis Artifacts
All analysis files preserved at: `{BASE_DIR}/`
- Screenshots: `{BASE_DIR}/screenshots/`
- Analysis reports: `{BASE_DIR}/reports/`

## Limitations of Image-Based Analysis
- **Font families:** Identified by visual characteristics only; exact font names require confirmation
- **Exact colors:** Estimated from visual inspection; may vary from actual hex values
- **Interactions:** Cannot observe hover states, animations, or transitions from static images
- **Responsive behavior:** Only visible breakpoint can be analyzed
- **Code patterns:** Cannot detect CSS framework, component library, or code structure

## Notes
[Any additional context or decisions made during specification]
```

### Step 8: Handle New Style Additions

If the user confirms a new style should be added, tell them:

"To add **[New Style Name]** to the reference database, add this entry to both:
- `~/.claude/commands/ui/create-style-from-url.md`
- `~/.claude/commands/ui/create-style-from-image.md`

In the appropriate category table:

```markdown
| **[New Style Name]** | [Key characteristics] | [Example products] |
```

I recommend adding it to the **[suggested category]** section."

### Step 9: Save Style Guide and Offer Next Steps

**First, always ask:**
- "Should I save this style specification as `{BASE_DIR}/STYLE_GUIDE.md`? This will serve as the reference for creating new page specifications."

**Then, based on the user's chosen libraries/tools from Step 6, offer to create relevant config files:**

| Technology Choice | Offer to Create |
|-------------------|-----------------|
| Tailwind CSS | `{BASE_DIR}/tailwind.config.ts` with colors, fonts, spacing, border-radius presets |
| UnoCSS | `{BASE_DIR}/uno.config.ts` with theme tokens and shortcuts |
| CSS Variables | `{BASE_DIR}/variables.css` with all design tokens |
| shadcn/ui or shadcn-vue | `{BASE_DIR}/components.json` with style presets |
| Theme (dark/light) | `{BASE_DIR}/theme.ts` with theme configuration |

**Ask the user which additional files they want:**
- "Based on your choices, I can generate these config files. Which would you like?"
  - `tailwind.config.ts` - Tailwind theme with extracted colors, fonts, spacing, and border-radius
  - `uno.config.ts` - UnoCSS theme configuration with tokens and shortcuts
  - `variables.css` - CSS custom properties for all design tokens
  - `theme.ts` - TypeScript theme object for CSS-in-JS solutions
  - `components.json` - shadcn/shadcn-vue component configuration

**Additional options:**
- "Should I create example components demonstrating this style?"
- "Do you want to keep all analysis artifacts in `{BASE_DIR}/` or move them to a different location?"
- "Do you have access to the actual site or design files to verify my color/font estimates?"

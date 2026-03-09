---
name: brand-guidelines
description: Applies Fortizar's official brand colors and typography to any sort of artifact that may benefit from having Fortizar's look-and-feel. Use it when brand colors or style guidelines, visual formatting, or company design standards apply.
---

# Fortizar Brand Styling

## Overview

To access Fortizar's official brand identity and style resources, use this skill.

**Keywords**: branding, corporate identity, visual identity, post-processing, styling, brand colors, typography, Fortizar brand, visual formatting, visual design

## Brand Guidelines

### Colors

**Primary Colors (Monochrome):**

- Black: `#000000` - Primary text, dark backgrounds, logo, footer bars
- White: `#FFFFFF` - Light backgrounds, text on dark, logo on dark backgrounds
- Light Gray: `#F0F0F0` - Watermarks, subtle backgrounds, soft dividers

**Accent Color:**

- Red: `#ec1111` - Single accent for highlights, calls-to-action, charts, links, emphasis

### Typography

- **Headings**: Calibri Bold (with Arial fallback)
- **Body Text**: Calibri (with Arial fallback)
- **Font files**: Available at `projects/fortizar/media/fonts/` (calibri.ttf, calibrib.ttf)

### Logo

- **Icon**: Geometric fortress/castle shield - hexagonal shape with turrets
- **Wordmark**: "FORTIZAR" in a custom angular sans-serif typeface with wide letter-spacing
- **Variants**: White on black, black on white
- **Logo files**: Available at `projects/fortizar/media/logo/`

## Features

### Smart Font Application

- Applies Calibri Bold to headings (24pt and larger)
- Applies Calibri to body text
- Automatically falls back to Arial if Calibri is unavailable
- Preserves readability across all systems

### Text Styling

- Headings (24pt+): Calibri Bold
- Body text: Calibri
- Text on dark backgrounds: White (`#FFFFFF`)
- Text on light backgrounds: Black (`#000000`)
- Preserves text hierarchy and formatting

### Shape and Accent Colors

- Non-text shapes and highlights use the red accent (`#ec1111`)
- Use the accent sparingly to preserve the minimalist monochrome identity
- Charts and data visualizations can use Black, Red, and Light Gray for differentiation

## Design Principles

- **High contrast**: Bold black and white with minimal gray
- **Minimalist**: Clean, uncluttered layouts with generous whitespace
- **Geometric**: Angular, structured shapes reflecting the fortress motif
- **Monochrome-first**: The accent red should be used sparingly for emphasis, not decoration

## Technical Details

### Font Management

- Uses system-installed Calibri / Calibri Bold when available
- Provides automatic fallback to Arial (both headings and body)
- No font installation required - works with existing system fonts
- For best results, install Calibri fonts from `projects/fortizar/media/fonts/`

### Color Application

- Uses RGB color values for precise brand matching
- Applied via python-pptx's RGBColor class
- Maintains color fidelity across different systems

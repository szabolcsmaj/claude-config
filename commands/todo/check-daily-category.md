---
description: Categorize diary tasks and notes by topic/domain
---

# Check Daily Category

Analyze the tasks and notes in an Obsidian diary note and categorize them by topic/domain.

## Instructions

1. **Find the target file:**
   - If an argument is provided (`$ARGUMENTS`), look for: `/home/sloby/notes/Main Vault/Diary/$ARGUMENTS.md`
   - If NO argument is provided, use Glob to find all `.md` files in the root of `/home/sloby/notes/Main Vault/Diary/`, sort by filename descending (files are YYYYMMDD.md format), and pick the first one

2. **Read the file** using the Read tool. This file contains tasks and notes for that day.

3. **Extract all unchecked tasks** - lines matching `- [ ]` pattern, including nested ones with indentation

4. **Categorize each task by topic.** Use the following categories as a starting point, but create new ones if needed based on the content. **Each task must have a sub-category.** If it's difficult to determine a specific sub-category, use "Misc."

   **💻 Development** - Software/code related:
   - Odoo (features, bug fixes, modules)
   - Infrastructure (servers, DevOps, CI/CD)
   - Database (backups, data warehouse, queries)
   - Integrations (APIs, plugins, sync)
   - Misc.

   **📦 Business Operations** - Day-to-day business:
   - Inventory (stock management, stock value)
   - Sales (CRM, customers, orders)
   - Logistics (shipping, delivery)
   - Reporting (analytics, dashboards)
   - Misc.

   **💰 Financial** - Money-related:
   - Investments (TBSZ, stocks, brokers)
   - Invoicing (billing, payments)
   - Budgeting (planning, forecasts)
   - Misc.

   **📅 Meetings** - Scheduled events:
   - Team (internal meetings)
   - Client (external calls)
   - 1:1 (one-on-ones, check-ins)
   - Misc.

   **👥 People** - Tasks related to specific people:
   - Delegation (assigning work to others)
   - Follow-up (waiting on someone)
   - Request (someone asked you for something)
   - Misc.

   **🏠 Personal** - Non-work related:
   - Health (fitness, medical, wellness)
   - Family (kids, relatives)
   - Hobbies (sports, games, learning)
   - Self-improvement (habits, mindset)
   - Misc.

   **⚙️ Admin** - Administrative tasks:
   - Compliance (GDPR, legal, documentation)
   - Access (permissions, credentials, SSH)
   - Setup (configuration, installation)
   - Misc.

   **📚 Reading/Research** - Content to consume:
   - Articles (Reddit, blogs, news)
   - Videos (YouTube, tutorials, courses)
   - Books (reading list)
   - Misc.

5. **Output the results** in this format. **Only include categories and sub-categories that have tasks - skip empty ones entirely.**

### File Analyzed
`{filepath}`

### Tasks by Category

---

#### 💻  Development
- **Odoo**
  - Task 1
  - Task 2
- **Infrastructure**
  - Task 1

---

#### 📦  Business Operations
- **Inventory**
  - Task 1
- **Sales**
  - Task 1

---

#### 💰  Financial
- **Investments**
  - Task 1
- **Invoicing**
  - Task 1

---

#### 📅  Meetings
- **Team**
  - Task 1
- **Client**
  - Task 1

---

#### 👥  People
- **Delegation**
  - Task 1 (Person)
- **Follow-up**
  - Task 1 (Person)

---

#### 🏠  Personal
- **Health**
  - Task 1
- **Family**
  - Task 1

---

#### ⚙️  Admin
- **Compliance**
  - Task 1
- **Access**
  - Task 1

---

#### 📚  Reading/Research
- **Articles**
  - Task 1
- **Videos**
  - Task 1

---

### Summary
- 💻  Development: X (X%)
- 📦  Business Operations: X (X%)
- 💰  Financial: X (X%)
- 📅  Meetings: X (X%)
- 👥  People: X (X%)
- 🏠  Personal: X (X%)
- ⚙️  Admin: X (X%)
- 📚  Reading/Research: X (X%)
- **Total: X**

### Notes
- Every task must have a sub-category; use "Misc." if no specific sub-category fits
- If a task fits multiple categories, place it in the most relevant one
- Nested tasks should inherit context from their parent when determining category
- Create new sub-categories as needed based on content patterns

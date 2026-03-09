# 💤 Neovim Configuration

Neovim configuration ที่ใช้ [LazyVim](https://github.com/LazyVim/LazyVim) เป็น base framework โดยใช้ [lazy.nvim](https://github.com/folke/lazy.nvim) เป็น plugin manager

Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## โครงสร้างไฟล์

### Entry Point

- `init.lua` — จุดเริ่มต้นของ Neovim config ทั้งหมด

### Core Config (`lua/config/`)

| ไฟล์ | หน้าที่ |
|------|---------|
| `lazy.lua` | ตั้งค่า lazy.nvim plugin manager และ bootstrap |
| `options.lua` | ตั้งค่า Neovim options (เช่น `tabstop`, `number`, etc.) |
| `keymaps.lua` | กำหนด custom key mappings |
| `autocmds.lua` | กำหนด autocommands |

### Plugins (`lua/plugins/`)

| ไฟล์ | หน้าที่ |
|------|---------|
| `conform.lua` | ตั้งค่า code formatter (conform.nvim) |
| `example.lua` | ตัวอย่าง plugin spec จาก LazyVim |
| `go.lua` | ตั้งค่า Go development support |
| `opencode.lua` | ตั้งค่า OpenCode plugin (AI coding assistant) |
| `surround.lua` | ตั้งค่า mini.surround สำหรับจัดการ surrounding characters |
| `windsurf.lua` | ตั้งค่า Windsurf plugin (AI coding assistant) |

### ไฟล์อื่นๆ

| ไฟล์ | หน้าที่ |
|------|---------|
| `lazy-lock.json` | Lock file ของ lazy.nvim (ล็อกเวอร์ชัน plugin) |
| `lazyvim.json` | LazyVim extras configuration |
| `stylua.toml` | ตั้งค่า StyLua (Lua formatter) |

## Plugin Setup

### mini.surround

Keybindings ที่ custom ไว้:

- **`sa`** — เพิ่ม surround (add)
- **`sd`** — ลบ surround (delete)
- **`gsr`** — เปลี่ยน surround (replace)
- **`gsf` / `gsF`** — ค้นหา surround
- **`gsh`** — highlight surround
- **`gsn`** — update n lines

## สรุป

| ด้าน | รายละเอียด |
|------|-----------|
| **Framework** | LazyVim (starter template) |
| **ภาษาหลักที่พัฒนา** | Go |
| **AI Tools** | Windsurf + OpenCode |
| **Formatter** | conform.nvim + StyLua |
| **สไตล์** | ใช้ LazyVim defaults เป็นหลัก แล้ว override เฉพาะจุด |

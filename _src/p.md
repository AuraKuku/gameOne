# 🐱 CatFeeder - Project Plan

## 🎮 Game Overview

**Name**: CatFeeder
**Genre**: Strategic Life Sim / Visual Novel (inspired by Persona 5 daily sim)

### 📖 Story Summary

The protagonist wakes from a 15-year coma at age 40, finding himself alone with no family or friends. To find purpose, he starts caring for homeless cats—buying food, treating sick ones, and eventually building a shelter. Along the way, he works various jobs and develops new relationships.

---

## ✅ Project Roadmap

### 📁 PHASE 0: Project Setup

* [x] Create Flutter project and push to GitHub repo
* [x] Add dependencies: `flame`, `shared_preferences`, etc.
* [x] Organize folders: `screens/`, `models/`, `widgets/`, `data/`, `assets/`

---

### 🎮 PHASE 1: Core Navigation & UI

#### 🎬 Screen "Main Menu"

* [x] `Start New Game` → navigate to "Story" with param "new_game"
* [x] `Load Game` → navigate to "Load"
* [x] `Gallery` → navigate to "Gallery"
* [x] `Exit` → closes application

#### 🌆 Screen "Story" with a parameter $storyname

* [ ] read a list of actions for a story based on the $storyname
* [ ] implement execution of actions (check doc p_actions)
* [ ] background is taken by default from the "Location" screen


#### 🌆 Screen "Load"

* [ ] output list of available loads. 
* [ ] click on a selected load icon will load data and navigate to the corresponding screen

#### 🌆 Screen "Save"

* [ ] output list of available save slots.
* [ ] click on a selected save slot with save a data under the selected slot id 


#### 🌆 Screen "Location"

* [ ] Display city map with tappable locations (initially 2-3 unlocked)
* [ ] Initial locations: Job Center, Home, Supermarket, Park
* [ ] Show day counter and time slots (Morning, Afternoon, Evening)

---

### 📅 PHASE 2: Time & Day System

* [ ] Implement day progression system
* [ ] Define actions per time slot
* [ ] Rest at night to start a new day

---

### 📦 PHASE 3: Core Game Systems

#### 💼 Work & Money

* [ ] Add simple jobs (e.g., supermarket)
* [ ] Earn money per visit with variable pay
* [ ] Add cooldowns or job requirements

#### 🐱 Cat Interaction System

* [ ] Feed a cat (requires money + time)
* [ ] Heal an ill cat (requires medicine + money)
* [ ] Build relationship meter with cats
* [ ] Add shelter system in later phase

---

### 👤 PHASE 4: Characters & Story

* [ ] Define NPC structure: name, portrait, flags
* [ ] Create simple visual novel dialogue system
* [ ] Meet NPCs at specific places/times
* [ ] Add branching choices and relationship impact

---

### 💾 PHASE 5: Save/Load System

* [ ] Implement auto-save at end of day
* [ ] Manual save/load via menu
* [ ] Save player state: day, money, cats, flags

---

### 📸 PHASE 6: Gallery System

* [ ] Unlockable cat photos or story scenes
* [ ] Unlock conditions based on events or milestones

---

### 📱 PHASE 7: Polish

* [ ] Add background music and sound effects
* [ ] Implement transitions and animations
* [ ] UI/UX responsiveness and polish

---

### 🔁 Post-MVP Features

* Shelter upgrades and management
* Expanded character arcs
* Random events and surprises
* Cat adoption system

---

## 🔧 Current Progress Checklist

* [ ] GitHub repo initialized
* [ ] Flutter project created and pushed
* [ ] Main menu screen scaffolded
* [ ] Navigation system implemented
* [ ] City screen with time system started

---


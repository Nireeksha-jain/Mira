# Mira

**An iOS app designed by women, for women, that turns cycle, sleep and movement patterns into simple, phase specific insights.**

Built in four weeks by a team of six as part of the **Apple Foundation Program at RMIT University** (Cohort 3, 2026), and presented to Apple iOS developers, RMIT lecturers, alumni and university leadership.

> The project folder uses the working title `Beyond_The_Cycle`. Open `Mira.xcodeproj`.

## What it does

Most cycle apps show a dashboard of numbers nobody has time to decode. Mira tells you which phase of your cycle you are in and what your body might need right now.

* **Home** shows the current cycle phase, a week strip, a mood check in and daily tips.
* **Calendar** shows a monthly view with each day coloured by cycle phase (menstrual, follicular, ovulation, luteal), with consecutive days merged into continuous phase bands.
* **Insight** shows phase specific feelings and practical tips for the current phase.
* **Emotion check in** asks how you feel, your stress level and what your body is noticing.
* **Reminder pop up** prompts a check in, with options to do it now or later.

## Tech

* **Swift** and **SwiftUI**
* **Xcode**, targeting iOS 26.5
* **Figma** for design, with the design system translated directly into SwiftUI
* Prototype data: the calendar generates sample cycle phases for the current month; a `CycleDay` model holds the phase, step count and sleep hours for each day

## Design system

The visual design lives in Figma, and `Extensions/DesignSystem.swift` mirrors the Figma variable collection token by token, so the app and the design file stay in sync.

* **Colours** are grouped as in Figma: system, cycle phase, green, purple and emoji
* **Typography** tokens use the Urbanist font family to match Figma (for example `dsHeadingEB32`), with extra shared text styles in `Extensions/Typography.swift`
* Views use tokens such as `Color.cycleGreen` and `Font.dsHeadingB20` instead of hard coded values

## Project structure

```
Beyond_The_Cycle/
  Beyond_The_Cycle/      App entry point and tab navigation (ContentView)
  Models/                CycleDay data model and CyclePhase
  Views/                 HomeView, CalendarView, InsightView,
                         EmotionCheckInView, ReminderPopUp
  Extensions/            DesignSystem, Typography, AppColors, Date helpers
  Mira.xcodeproj         Xcode project
```

## Running the app

1. Clone the repository.
2. Open `Beyond_The_Cycle/Mira.xcodeproj` in Xcode.
3. Choose an iPhone simulator and press Run.

## My role

I am **Nireeksha Jain Sankighatta Santhosh**. On this team I:

* built the **CalendarView** and **InsightView**
* built the **design system**, translating Figma tokens into reusable SwiftUI colours and typography
* set up the team's **Git workflow** so everyone could work on the same codebase
* worked through Xcode build and target membership issues

Apple HealthKit integration was explored early on and cut from the final build to meet the four week deadline.

## Team

Sahasra Neerukonda, Eudora H, Chau Anh L., Nguyen Hien Nhi, Fransisca Kho and Nireeksha Jain Sankighatta Santhosh.

**Mentors:** Ace A, Beck Storer and Steph Worladge, Apple Foundation Program at RMIT.

# PetroPump Manager

Offline petroleum pump (fuel station) management software for Windows PC / laptop.
Built with **C# / .NET 8 / Windows Forms** and an embedded **SQLite** database - no internet or server needed.

## Features
- Secure login (PBKDF2 hashed passwords, lock-out after repeated failures)
- **Forgot password** -> client is told to contact the provider; the provider supplies a *Master Password* to reset
- Modern dashboard: today's sales, 7-day sales chart, live tank levels, recent sales, alerts
- **Shifts**: open shift with nozzle meter readings, close shift with closing readings, test litres, expected vs declared cash (shortage / excess)
- **Daily sales**: credit fuel sales and lubricant / shop sales, thermal (80 mm) receipt printing
- **Tanks**: tank setup, calibration chart (dip cm -> litres), dip readings, tanker (fuel) receipts
- **Customers**: credit accounts, credit limits, ledger / statement, payment recovery
- **Lubricants & shop stock** with reorder alerts
- **Reports**: sales summary, shortage / excess, financial report (print preview + CSV export)
- **Settings**: station details, fuel prices, nozzles, change password, database backup (daily auto-backup too)

## Solution structure
```
PetroleumPumpManagement/
|-- PetroleumPumpManagement.sln
|-- PetroleumPump.Core      Models, Interfaces, Services (business logic)
|-- PetroleumPump.Data      SQLite context, Repositories, Scripts/DatabaseSchema.sql
`-- PetroleumPump.Desktop   Windows Forms UI (Views, Utilities, Program.cs, App.config)
```

## Build & run
Requirements: Windows 10/11, [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)

```
dotnet build PetroleumPumpManagement.sln -c Release
dotnet run --project PetroleumPump.Desktop
```
Or open `PetroleumPumpManagement.sln` in Visual Studio 2022 and press F5.

### Release package for the client PC
Run `publish.bat` (self-contained single file - the client does **not** need .NET installed), or let the
GitHub Actions workflow (`.github/workflows/build.yml`) build it and download the `PetroPumpManager-win-x64` artifact.

## Data location
`%LocalAppData%\PetroleumPump\` contains `petroleum_pump.db`, `Backups\` (daily) and `Logs\`.

## Provider notes (keep private)
- A default administrator account is created on first run. Give the credentials to the client separately and ask them to change the password in *Settings > Security*.
- Provider contact details shown on the *Forgot password* screen are configured in `PetroleumPump.Desktop/App.config`.
- The master password is stored only as a salted-style SHA-256 hash in `PetroleumPump.Core/Services/AuthService.cs` (`MasterPasswordHash`). To change it, compute `SHA256("PetroPump|<new password>")` as upper-case hex and replace the constant.
- Use a **private** GitHub repository for this project.

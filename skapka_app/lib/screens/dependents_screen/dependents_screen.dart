import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

@RoutePage()
class DependentsScreen extends StatelessWidget {
  const DependentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String markdownString = '''## Přehled změn (Changelog)

---

### 📱 Obrazovky a UI Logika

* **Navigace**: Implementován spodní navigační panel s `navbar_dashboard` pro plynulé přecházení mezi hlavními sekcemi aplikace.
* **`settings_screen`**: Přidána obrazovka nastavení s funkcí pro odhlášení uživatele.
* **Startup Logika**: Při spuštění aplikace automaticky probíhá:
* Stažení detailů uživatele a všech k němu přidružených `dependents`.
* Stažení veškerých událostí (events) odpovídajících `group_id` daného uživatele.


* **`auth_gate`**: Upraveno pro stahování dat o oddílech, družinách a střediscích do `units_provider`.
* **`calendar_screen`**: Implementováno rozdělení událostí: **Nadcházející**, **Přihlašování**, **Proběhlé** a **Koncepty**.
* *Widgety*: `events_expansion_tile`.


* **`create_edit_events_screen`**: Centralizovaná správa událostí (nahrazuje `create_event_screen`).
* *Komponenty*: `participant_row`, `patrol_expansion_tile`, výběr data, `event_instructions_container`, `event_participants_container`, `event_title_form`.
* *Ovládání*: `create_edit_event_speed_dial` (dynamické akce), `content_switcher`, `form_with_details`.
* Pod-obrazovka pro výběr účastníků a rozpracovaná editace pokynů.


* **`event_details_screen`**: Rozšířeno zobrazení informací ve widgetu `event_box`.

---

### 🧩 Widgety

* **`loading_floating_logo`**: Přejmenováno z `floating_logo`.
* **`screen_wrapper`**: Přidána možnost odstranění defaultního paddingu.

---

### 🏗️ Datové Modely

* **`dependent`**: Aktualizován dle schématu Supabase.
* **`event`**: Přidána pole `instructions`, `targetPatrolsIds`, `lastEditedBy`. Implementovány `copyWith` a operátory.
* **`event_participant`**: Nový model pro tabulku `event_participants`.
* **`leader` & `leader_dependent**`: Modely pro správu vedoucích a jejich kompetencí.
* **`patrol` & `troop**`: Modely pro družiny a oddíly.

---

### 💾 Backend a State Management

* **`units_provider`**: Správa skautských jednotek střediska.
* **`events_provider`**: State management pro data z tabulky `events`.
* **`event_utils`**: Logika pro určování `EventTimeType`.
* **`supabase_service`**: Rozšíření o funkce pro komplexní dotazy a startup synchronizaci.

---

### 🎨 Design a Zdroje

* **`app_decorations`**: Centralizované UI styly.
* **Podklady (Assets)**: Implementovány nové `.svg` a `.png` grafické prvky.
* **Lokalizace**: Plná podpora více jazyků, implementace zkratek pro překlady.

---

### ⚙️ Ostatní

* **Router**: Aktualizace generovaných rout pro navigaci.
* **Haptika**: Implementována vibrační odezva systému.
* **Závislosti**: Přidán package `custom_sliding_segmented_control`.''';
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: MarkdownBody(
            data: markdownString,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h1: AppTextTheme.titleLarge(context),
              h2: AppTextTheme.titleMedium(context),
              h3: AppTextTheme.titleSmall(context),
              p: AppTextTheme.bodyMedium(context),
              strong: AppTextTheme.bodyMediumBold(context),
              listBullet: AppTextTheme.bodyMedium(context),
              horizontalRuleDecoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.colors.background.medium,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

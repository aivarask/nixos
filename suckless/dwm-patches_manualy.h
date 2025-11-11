/* Enhanced taskbar that shows the titles of all visible windows in the status bar
 * and allows focus / hiding / unhiding of windows by clicking on the status bar.
 * Awesomebar takes precedence over fancybar.
 * https://dwm.suckless.org/patches/awesomebar/
 */
#define BAR_AWESOMEBAR_PATCH 0

/* Show status in bar */
#define BAR_STATUS_PATCH 1

/* Show tag symbols in the bar. */
#define BAR_TAGS_PATCH 1

/* Show window title in bar */
#define BAR_WINTITLE_PATCH 1

/* All floating windows are centered, like the center patch, but without a rule.
 * The center patch takes precedence over this patch.
 * This patch interferes with the center transient windows patches.
 * https://dwm.suckless.org/patches/alwayscenter/
 */
#define ALWAYSCENTER_PATCH 1

/* When terminals have transparency then their borders also become transparent.
 * This patch ensures that borders have no transparency. Note that this patch is
 * only relevant if you are not using the alpha patch.
 * https://github.com/szatanjl/dwm/commit/1529909466206016f2101457bbf37c67195714c8
 * https://dwm.suckless.org/patches/alpha/dwm-fixborders-6.2.diff
 */
#define NO_TRANSPARENT_BORDERS_PATCH 1

/* Adds a keyboard shortcut to restart dwm or alternatively by using kill -HUP dwmpid.
 * Additionally dwm can quit cleanly by using kill -TERM dwmpid.
 * https://dwm.suckless.org/patches/restartsig/
 */
#define RESTARTSIG_PATCH 1

/* Allows restarting dwm without the dependency of an external script.
 * https://dwm.suckless.org/patches/selfrestart/
 */
#define SELFRESTART_PATCH 1

/* This patch allows you to toggle fullscreen on and off using a single shortcut key.
 * https://github.com/bakkeby/patches/blob/master/dwm/dwm-togglefullscreen-6.2.diff
 */
#define TOGGLEFULLSCREEN_PATCH 1

/* Allows dwm to read colors from xrdb (.Xresources) during runtime. Compatible with
 * the float border color, awesomebar, urgentborder and titlecolor patches.
 * https://dwm.suckless.org/patches/xrdb/
 */
#define XRDB_PATCH 1

/* The default tile layout.
 * This can be optionally disabled in favour of other layouts.
 */
#define TILE_LAYOUT 1

/* Monocle layout (default).
 * This can be optionally disabled in favour of other layouts.
 */
#define MONOCLE_LAYOUT 1

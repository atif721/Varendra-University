/**
 * Shared front-end helpers for the Medicine Shop Billing System.
 */

document.addEventListener('DOMContentLoaded', function () {
    // Confirm before any element marked with data-confirm is followed.
    document.querySelectorAll('[data-confirm]').forEach(function (element) {
        element.addEventListener('click', function (event) {
            if (!window.confirm(element.getAttribute('data-confirm'))) {
                event.preventDefault();
            }
        });
    });

    // Print buttons.
    document.querySelectorAll('[data-print]').forEach(function (button) {
        button.addEventListener('click', function () {
            window.print();
        });
    });
});

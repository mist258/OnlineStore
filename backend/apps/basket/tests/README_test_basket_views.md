---

# 🧺 Basket API Test Overview

---

## 1. What is done

### 🟢 TestActiveBasketView - Active Basket

* `test_get_basket_authenticated` - Authenticated user can retrieve their active basket.
* `test_get_basket_guest` - Guest users can retrieve a basket; `guest_token` is included.

### ➕ TestAddBasketItemView - Add Items

* `test_add_item_authenticated` - Authenticated user can add an item to the basket.
* `test_add_item_guest` - Guest user can add an item; `guest_token` cookie is set.

### ✏️ TestUpdateBasketItemView - Update Items

* `test_update_item_quantity` - Authenticated user can update basket item quantity via PUT.
* `test_partial_update_item` - Authenticated user can partially update basket item via PATCH.

### 🗑️ TestDeleteBasketItemView - Delete Items

* `test_delete_item` - Authenticated user can delete a basket item; item is removed from DB.
* `test_delete_nonexistent_item` - Deleting a non-existent item returns `404 Not Found`.

---

## 2. What is planning


---

## 3. Suggestions

* Add tests for **clearing the basket** (`TestClearBasketView`).
* Test **adding invalid products** (e.g., inactive or non-existent product).
* Include **quantity validation** (negative or zero quantities).
* Add **permission edge cases** for basket items (e.g., another user trying to delete/update).
* Test **basket merging for guest → authenticated login** scenarios.
* Test **response consistency** (basket totals, item count, etc.) after multiple add/update/delete operations.

---
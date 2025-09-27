---

# 🧪 Order API Test Overview

---

## 1. What is done

### 🛒 TestCreateOrderView - Order Creation

* `test_create_order_authenticated` - Authenticated user can create an order from a basket. Response includes `customer` and `positions`.

### 📖 TestOrderDetailsView - Order Details

* `test_get_order_details` - Authenticated user can fetch their own order details.
* `test_get_nonexistent_order` - 404 returned when fetching a non-existent order.

### ✏️ TestUpdateOrderView - Order Updates

* `test_update_order_status` - Admin can update order `status`. Email notification is triggered (mocked).
* `test_update_order_notes` - Admin can update `order_notes`.

### 🔒 TestOrderPermissions - Permissions

* `test_guest_cannot_access_orders` - Guests cannot list orders (`401`).
* `test_user_can_only_access_own_orders` - Users cannot access other users’ orders (`404`).

### ⚠️ TestOrderValidation - Validation

* `test_create_order_without_basket` - Creating an order without `basket_id` returns `400 Bad Request`.
* `test_create_order_with_empty_basket` - Creating an order with an empty basket returns `400 Bad Request`.

---

## 2. What is planning

* ❌ (empty)

---

## 3. Suggestions

* Add tests for **updating multiple fields at once** in `TestUpdateOrderView`.
* Test **unauthorized update attempts** (non-admin users).
* Cover **invalid status transitions** (e.g., `delivered → pending`).
* Include **order cancellation / deletion workflow**.
* Add **email sending checks** for other status changes (`shipped`, `canceled`).
* Test **edge cases in order creation**:

  * Guest trying to create an order.
  * Basket containing invalid or inactive products.
  * Invalid billing details.
* Consider **parametrized tests** (`pytest.mark.parametrize`) to reduce duplication.

---

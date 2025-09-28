---

# 🎟️ Discount Code API Test Overview

---

## 1. What is done

### ✅ TestDiscountCodeView - Discount Code Retrieval

* `test_get_valid_discount_code` - Retrieves a valid discount code successfully; returns `is_valid=True`.
* `test_get_invalid_discount_code` - Retrieving a non-existent or invalid code returns `404 Not Found`.

---

## 2. What is planning

* `test_get_apply_discount_with_order()` - recheck after modifying order positions
* 

---

## 3. Suggestions

* Test **expired discount codes**.
* Test **usage limits** (e.g., code already used or max uses reached).
* Test **discount type behavior** (percentage vs fixed amount).
* Test **unauthorized access** if the API has any restrictions.
* Test **basket integration**: applying discount code when creating/updating a basket.

---
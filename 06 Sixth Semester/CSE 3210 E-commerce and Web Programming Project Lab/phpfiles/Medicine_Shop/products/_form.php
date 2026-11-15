<?php
/**
 * Shared add/edit product form.
 * Expects: $product (array), $categories (mysqli result), $form_action, $errors.
 */
if (!isset($product, $categories, $form_action)) {
    http_response_code(404);
    exit;
}

$mrp_warning = !empty($product['selling_price']) && !empty($product['mrp'])
    && (float) $product['selling_price'] > (float) $product['mrp'];
?>
<?php if ($errors): ?>
    <div class="alert alert-danger">
        <ul class="mb-0 ps-3">
            <?php foreach ($errors as $error): ?><li><?= e($error) ?></li><?php endforeach; ?>
        </ul>
    </div>
<?php endif; ?>

<form method="post" action="<?= e($form_action) ?>">
    <div class="card mb-3">
        <div class="card-header bg-white fw-semibold">Medicine Information</div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="name" class="form-label">Product Name <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="name" name="name" maxlength="150"
                           value="<?= e($product['name']) ?>" required autofocus>
                </div>

                <div class="col-md-6">
                    <label for="generic_name" class="form-label">Generic Name</label>
                    <input type="text" class="form-control" id="generic_name" name="generic_name" maxlength="150"
                           value="<?= e($product['generic_name']) ?>">
                </div>

                <div class="col-md-4">
                    <label for="category_id" class="form-label">Category <span class="text-danger">*</span></label>
                    <select class="form-select" id="category_id" name="category_id" required>
                        <option value="">Select category</option>
                        <?php mysqli_data_seek($categories, 0); ?>
                        <?php while ($category = mysqli_fetch_assoc($categories)): ?>
                            <option value="<?= (int) $category['id'] ?>"
                                <?= (int) $product['category_id'] === (int) $category['id'] ? 'selected' : '' ?>>
                                <?= e($category['name']) ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>

                <div class="col-md-4">
                    <label for="unit" class="form-label">Unit <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="unit" name="unit" maxlength="50"
                           list="unit-options" value="<?= e($product['unit']) ?>" required>
                    <datalist id="unit-options">
                        <option value="Piece">
                        <option value="Strip">
                        <option value="Box">
                        <option value="Bottle">
                        <option value="Tube">
                        <option value="Vial">
                        <option value="Sachet">
                        <option value="Pack">
                    </datalist>
                </div>

                <div class="col-md-4">
                    <label for="expiry_date" class="form-label">Expiry Date <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" id="expiry_date" name="expiry_date"
                           value="<?= e($product['expiry_date']) ?>" required>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-white fw-semibold">Pricing</div>
        <div class="card-body">
            <div class="alert alert-warning py-2 small<?= $mrp_warning ? '' : ' d-none' ?>" id="mrp-warning">
                <i class="bi bi-exclamation-triangle me-1"></i>
                Selling price is higher than the printed MRP. Please double-check this price.
            </div>

            <div class="row g-3">
                <div class="col-md-4">
                    <label for="cost_price" class="form-label">Cost Price (<?= e(CURRENCY) ?>)</label>
                    <input type="number" class="form-control" id="cost_price" name="cost_price"
                           min="0" step="0.01" value="<?= e($product['cost_price']) ?>" required>
                </div>

                <div class="col-md-4">
                    <label for="selling_price" class="form-label">Selling Price (<?= e(CURRENCY) ?>)</label>
                    <input type="number" class="form-control" id="selling_price" name="selling_price"
                           min="0" step="0.01" value="<?= e($product['selling_price']) ?>" required>
                </div>

                <div class="col-md-4">
                    <label for="mrp" class="form-label">Printed MRP (<?= e(CURRENCY) ?>)</label>
                    <input type="number" class="form-control" id="mrp" name="mrp"
                           min="0" step="0.01" value="<?= e($product['mrp']) ?>" required>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header bg-white fw-semibold">Stock</div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="stock" class="form-label">Stock Quantity <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" id="stock" name="stock"
                           min="0" step="1" value="<?= e($product['stock']) ?>" required>
                </div>

                <div class="col-md-6">
                    <label for="reorder_level" class="form-label">Reorder Level <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" id="reorder_level" name="reorder_level"
                           min="0" step="1" value="<?= e($product['reorder_level']) ?>" required>
                    <div class="form-text">A low-stock warning appears when stock reaches this level.</div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex gap-2 mb-4">
        <button type="submit" class="btn btn-success">
            <i class="bi bi-check2-circle me-1"></i>Save Product
        </button>
        <a href="<?= url('products/index.php') ?>" class="btn btn-outline-secondary">Cancel</a>
    </div>
</form>

<script>
(function () {
    var selling = document.getElementById('selling_price');
    var mrp = document.getElementById('mrp');
    var warning = document.getElementById('mrp-warning');

    function checkPrices() {
        var sellingValue = parseFloat(selling.value) || 0;
        var mrpValue = parseFloat(mrp.value) || 0;
        warning.classList.toggle('d-none', sellingValue <= mrpValue);
    }

    selling.addEventListener('input', checkPrices);
    mrp.addEventListener('input', checkPrices);
})();
</script>

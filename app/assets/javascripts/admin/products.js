$(document).ready(function() {
    $('.add-category').click(function() {
        var category_id = $(this).prev('select[name="categories_select"]').val();
        var product_id = $(this).data('id');
        $.post($(this).attr('href'),{
            "cp[category_id]": category_id,
            "cp[product_id]": product_id
        });
        return false;
    });
});
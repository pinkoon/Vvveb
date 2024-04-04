//set selector prefix to have shorter and easier to read selectors for rules
@products = [data-v-component-products]
@product  = [data-v-component-products] [data-v-product]
@product-image = [data-v-product-images] [data-v-product-image]

//we only need the first product element to iterate
@product|deleteAllButFirstChild

//set component variables
@products|prepend = <?php
	$vvveb_is_page_edit = Vvveb\isEditor();

	//use a counter to know which component instance we need to use if there are more than one component on page
	if (isset($products_idx)) $products_idx++; else $products_idx = 0;
	$previous_component = isset($current_component)?$current_component:null;
	$products = $current_component = $this->_component['products'][$products_idx] ?? [];

	$index = 0;
	$count = $products['count'] ?? 0;
	$limit = isset($products['limit'])? $products['limit'] : 5;

	//if page loaded in editor then set a fist empty product if there are no products 
	//to render an empty product to avoid losing the html on edit
	$_default = (isset($vvveb_is_page_edit) && $vvveb_is_page_edit ) ? [0 => []] : false;
	//$_default = [0 => []];
	$_products = empty($products['products']) ? $_default : $products['products'];
?>

@products [data-v-products-category] = <?php $_category = current($products);echo $_category['category'];?>
@products [data-v-products-count] = <?php echo $products['count'] ?? ''?>
@products [data-v-products-manufacturer] = <?php $_manufacturer = current($products);echo $_manufacturer['manufacturer'];?>


@product|before = <?php

if ($_products) {
	foreach ($_products as $index => $_product) { $index++;?>
	
	@product [data-v-product-*]|innerText = $_product['@@__data-v-product-(*)__@@']
	@product a[data-v-product-*]|href = $_product['@@__data-v-product-(*)__@@']

	//editor attributes
	@product|data-v-id = $_product['product_id']
	@product|data-v-type = 'product'
	
	//title attributes
	@product [data-v-product-alt]|alt = $_product['name']	
	
	@product [data-product_id]|data-product_id = $_product['product_id']

	//url
	@product [data-v-product-url]|title = $_product['name']	
	@product a[data-v-product-url]|href = $_product['url']	

	//image
	//@product [data-v-product-image]|src = $_product['images'][0]['image']
	//@product [data-v-product-image]|data-v-id = $_product['images'][0]['id']
	//@product [data-v-product-image]|data-v-type = 'product_image'
	
	@product [data-v-product-image]|src = <?php 
		if (isset($_product['image'])) {
			$image = $_product['image'] ?? '';
			//$size = '@@__data-v-product-image__@@';
			$size = '@@__data-v-size__@@';
			if ($size) {
				//$image = Vvveb\System\Images::size($image, $size);
				echo $image;
			} else {
				echo $image;
			}
		}
	?>
	
	@product [data-v-product-image-url] = $_product['image']
	//@product [data-v-product-image]|data-v-id = 'image'
	//@product [data-v-product-image]|data-v-type = 'product_image'
	
	//usually used for second image to show hover [data-v-product-image-0] [data-v-product-image-1] 
	//@product [data-v-product-image-*]|src = $_product['images']['@@__data-v-product-image-(\d+)__@@']['image']
	
	@product [data-v-product-image-*]|src =  <?php 
		//$size = '@@__data-v-product-image-\d+__@@';
		$size = '@@__data-v-size__@@';
		$nr = '@@__data-v-product-image-(\d+)__@@';
		if (isset($_product['images'][$nr]['image'])) {
			$image = $_product['images'][$nr]['image'];
			if ($size) {
				//echo imageSize($_product['image'], $size);
				//$image = Vvveb\System\Images::size($image, $size);
				echo $image;
			} else {
				echo $image;
			}
		}
	?>
	

	
	@product [data-v-product-image-*]|data-v-id = $_product['images']['@@__data-v-product-image-(\d+)__@@']['id']
	@product [data-v-product-image-*]|data-v-type = 'product_image'
	
	//image gallery
	@product [data-v-product-images] [data-v-product-image]|before = <?php
	if(isset($_product['images']) && is_array($_product['images']))
	foreach ($_product['images'] as $_product_image_id => $image)  {
	?>

		@product [data-v-product-images] img[data-v-product-image-src]|src = $image['image']
		@product [data-v-product-images] img[data-v-product-image-src]|data-v-id  = $_product_image_id
		@product [data-v-product-images] img[data-v-product-image-src]|data-v-type = 'product_image'
		@product [data-v-product-images] a[data-v-product-image-src]|href = $image['image']
		
		@product [data-v-product-images] [data-v-product-image]|after = <?php 
	} ?>

    //catch all data attributes
    @product [data-v-product-*]|innerText = $_product['@@__data-v-product-(*)__@@']
	//echo description directly to avoid htmlentities escape
	@product [data-v-product-content] = <?php echo $_product['content'];?>	
	
	@product|after = <?php 
	}
}

$current_component = $previous_component;
?>
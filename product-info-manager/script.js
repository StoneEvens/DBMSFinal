let productData = {};

async function searchProducts() {
  const searchInput = document.getElementById('searchInput');
  const searchTerm = searchInput.value.trim();

  if (searchTerm) {
    try {
      const response = await fetch(`http://localhost:3000/product?productName=${encodeURIComponent(searchTerm)}`);

      if (!response.ok) {
        if (response.status === 404) {
          // 產品不存在，顯示空白表單
          document.getElementById('location').value = '';
          document.getElementById('productName').value = searchTerm;
          document.getElementById('productCode').value = '';
          document.getElementById('price').value = '';
          document.getElementById('discount').value = '';
          document.getElementById('description').value = '';
          document.getElementById('productInfo').style.display = 'block';
          productData = {}; // 重置 productData
        } else {
          throw new Error('Network response was not ok');
        }
      } else {
        const data = await response.json();
        productData = data;

        document.getElementById('location').value = data.location;
        document.getElementById('productName').value = data.productName;
        document.getElementById('productCode').value = data.productCode;
        document.getElementById('price').value = data.price;
        document.getElementById('discount').value = data.discount;
        document.getElementById('description').value = data.description;

        document.getElementById('productInfo').style.display = 'block';
      }
    } catch (error) {
      console.error('Error fetching product data:', error);
      document.getElementById('productInfo').style.display = 'none';
    }
  } else {
    document.getElementById('productInfo').style.display = 'none';
  }
}

async function saveProductInfo() {
  productData.location = document.getElementById('location').value;
  productData.productName = document.getElementById('productName').value;
  productData.productCode = document.getElementById('productCode').value;
  productData.price = document.getElementById('price').value;
  productData.discount = document.getElementById('discount').value;
  productData.description = document.getElementById('description').value;

  try {
    let response;
    if (productData.id) {
      // Update existing product
      response = await fetch('http://localhost:3000/product', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(productData)
      });
    } else {
      // Create new product
      response = await fetch('http://localhost:3000/product', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(productData)
      });
    }

    if (response.ok) {
      document.getElementById('successMessage').style.display = 'block'; // 顯示成功訊息
      setTimeout(() => {
        document.getElementById('successMessage').style.display = 'none'; // 2秒後隱藏成功訊息
      }, 2000);
    } else {
      console.error('儲存失敗');
    }
  } catch (error) {
    console.error('儲存時發生錯誤:', error);
  }
}

async function deleteProduct() {
  if (productData.id) {
    try {
      const response = await fetch(`http://localhost:3000/product/${productData.id}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      if (response.ok) {
        document.getElementById('productInfo').style.display = 'none';
        document.getElementById('deleteMessage').style.display = 'block'; // 顯示刪除成功訊息
        setTimeout(() => {
          document.getElementById('deleteMessage').style.display = 'none'; // 2秒後隱藏刪除成功訊息
        }, 2000);
      } else {
        console.error('刪除失敗');
      }
    } catch (error) {
      console.error('刪除時發生錯誤:', error);
    }
  }
}

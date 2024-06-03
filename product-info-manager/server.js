const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Zz810410', // 替換為您的 MySQL 密碼
  database: 'productdb'
});

db.connect(err => {
  if (err) {
    console.error('無法連接到資料庫:', err);
    return;
  }
  console.log('成功連接到資料庫');
});

app.post('/product', (req, res) => {
  const { location, productName, productCode, price, discount, description } = req.body;
  const sql = 'INSERT INTO products (location, productName, productCode, price, discount, description) VALUES (?, ?, ?, ?, ?, ?)';
  
  db.query(sql, [location, productName, productCode, price, discount, description], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).send('商品資訊已新增');
  });
});

app.put('/product', (req, res) => {
  const { id, location, productName, productCode, price, discount, description } = req.body;
  const sql = 'UPDATE products SET location = ?, productName = ?, productCode = ?, price = ?, discount = ?, description = ? WHERE id = ?';
  
  db.query(sql, [location, productName, productCode, price, discount, description, id], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(200).send('商品資訊已更新');
  });
});

app.get('/product', (req, res) => {
  const { productName } = req.query;
  const sql = 'SELECT * FROM products WHERE productName = ?';

  db.query(sql, [productName], (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    if (results.length === 0) {
      return res.status(404).send('未找到商品');
    }
    res.status(200).send(results[0]);
  });
});

app.delete('/product/:id', (req, res) => {
  const { id } = req.params;
  const sql = 'DELETE FROM products WHERE id = ?';

  db.query(sql, [id], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(200).send('商品已刪除');
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

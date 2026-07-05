const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // Read JSON from Frontend

// Connect MongoDB
const mongoURI = process.env.MONGO_URI || 'mongodb://mongo-db:27017/todo-db';
mongoose.connect(mongoURI)
  .then(() => console.log('Connected to MongoDB Atlas Successfully!'))
  .catch(err => console.error('Could not connect to MongoDB', err));

// Define Todo data structure
const TodoSchema = new mongoose.Schema({
  text: { type: String, required: true },
  completed: { type: Boolean, default: false }
});
const Todo = mongoose.model('Todo', TodoSchema);

// --- API ROUTER  ---

// 1. Check backend status
app.get('/api', (req, res) => res.send('Backend is running!'));

// 2. Get todo list
app.get('/api/todos', async (req, res) => {
  try {
    const todos = await Todo.find();
    res.json(todos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 3. Add new todo
app.post('/api/todos', async (req, res) => {
  try {
    const newTodo = new Todo({ text: req.body.text });
    await newTodo.save();
    res.status(201).json(newTodo);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// 4. Delete todo
app.delete('/api/todos/:id', async (req, res) => {
  try {
    await Todo.findByIdAndDelete(req.params.id);
    res.json({ message: 'Deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
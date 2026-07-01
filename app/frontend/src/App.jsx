import { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [todos, setTodos] = useState([]);
  const [inputText, setInputText] = useState('');

  // Fetch data from Backend when page just loaded
  useEffect(() => {
    fetchTodos();
  }, []);

  const fetchTodos = async () => {
    try {
      const response = await axios.get('/api/todos');
      setTodos(response.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  // Add new Todo
  const handleAddTodo = async (e) => {
    e.preventDefault();
    if (!inputText.trim()) return;
    
    try {
      const response = await axios.post('/api/todos', { text: inputText });
      setTodos([...todos, response.data]);
      setInputText('');
    } catch (error) {
      console.error('Error adding todo:', error);
    }
  };

  // Delete Todo
  const handleDeleteTodo = async (id) => {
    try {
      await axios.delete(`/api/todos/${id}`);
      setTodos(todos.filter(todo => todo._id !== id));
    } catch (error) {
      console.error('Error deleting todo:', error);
    }
  };

  return (
    <div id="center">
      <h1>Cloud DevOps Todo App</h1>
      
      <form onSubmit={handleAddTodo} style={{ display: 'flex', gap: '10px', marginBottom: '20px' }}>
        <input 
          type="text" 
          value={inputText}
          onChange={(e) => setInputText(e.target.value)}
          placeholder="Enter a new todo..."
          style={{ padding: '10px', fontSize: '16px', borderRadius: '5px', border: '1px solid var(--border)' }}
        />
        <button type="submit" className="counter">Add</button>
      </form>

      <ul style={{ listStyle: 'none', padding: 0, width: '100%', maxWidth: '400px' }}>
        {todos.map(todo => (
          <li key={todo._id} style={{ 
              display: 'flex', 
              justifyContent: 'space-between', 
              alignItems: 'center',
              padding: '12px',
              borderBottom: '1px solid var(--border)',
              backgroundColor: 'var(--social-bg)',
              marginBottom: '8px',
              borderRadius: '5px'
            }}>
            <span>{todo.text}</span>
            <button 
              onClick={() => handleDeleteTodo(todo._id)}
              style={{ backgroundColor: '#ff4d4f', color: 'white', border: 'none', padding: '5px 10px', borderRadius: '3px', cursor: 'pointer' }}
            >
              Delete
            </button>
          </li>
        ))}
      </ul>
      
      {todos.length === 0 && <p style={{ color: 'var(--text)' }}>No todos available!</p>}
    </div>
  );
}

export default App;
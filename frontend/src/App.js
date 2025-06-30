import { useEffect, useState } from 'react';
import axios from 'axios';

const App = () => {
  const [texts, setText] = useState([]);

  useEffect(() => {
  axios.get('/api/initial').then(({ data }) => {

    if (Array.isArray(data.data)) {
      setText(data.data);
    } else {
      setText([]);
    }
  });
}, []);

  return (
  <div>
    {texts.map((text, i) => (
      <div key={text.id || i}>
        <h4>ID:</h4> {text.id} — <h3><em>{text.any_text}</em></h3>
      </div>
    ))}
  </div>
);
};

export { App };


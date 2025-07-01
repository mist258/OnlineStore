import { useEffect, useState } from 'react';
import axios from 'axios';

const App = () => {
  const [texts, setText] = useState([]);

  useEffect(() => {
  axios.get('/api/initial').then(({ data }) => {
      setText(data.data);
  });
}, []);

  return (
  <div>
    {texts.map((text, i) => (
      <div key={text.id || i}>
        <h3>{JSON.stringify(text)}</h3>
      </div>
    ))}
  </div>
);
};

export { App };


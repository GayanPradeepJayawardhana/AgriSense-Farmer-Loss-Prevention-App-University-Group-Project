export const askGemini = async (prompt, context = '') => {
  const apiKey = process.env.GEMINI_API_KEY;
  const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${apiKey}`;

  const systemContext = `You are an agricultural assistant specialized in Sri Lankan paddy farming. Provide concise, practical advice.`;
  const fullPrompt = `${systemContext}\nContext: ${context}\nUser: ${prompt}\nAssistant:`;

  const body = {
    contents: [{ parts: [{ text: fullPrompt }] }],
  };

  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });

  const data = await response.json();
  if (data.candidates && data.candidates[0]?.content?.parts?.[0]?.text) {
    return data.candidates[0].content.parts[0].text;
  }
  throw new Error('No response from Gemini');
};
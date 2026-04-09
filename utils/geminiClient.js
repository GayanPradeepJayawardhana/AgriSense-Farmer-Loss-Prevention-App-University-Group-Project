export const askGemini = async (prompt, context = '') => {
  const apiKey = process.env.GEMINI_API_KEY;
  
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY is not configured in environment variables');
  }

  const url = `https://generativelanguage.googleapis.com/v1p1/models/gemini-1.5-flash:generateContent?key=${apiKey}`;

  const systemContext = `You are an agricultural assistant specialized in Sri Lankan paddy farming. Provide concise, practical advice.`;
  const fullPrompt = context 
    ? `${systemContext}\n\nFarm Context: ${context}\n\nFarmer's Question: ${prompt}`
    : `${systemContext}\n\nFarmer's Question: ${prompt}`;

  const body = {
    contents: [
      {
        parts: [
          { text: fullPrompt }
        ]
      }
    ],
    generationConfig: {
      temperature: 0.7,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 1024,
    },
  };

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(`Gemini API Error (${response.status}): ${errorData.error?.message || 'Unknown error'}`);
    }

    const data = await response.json();
    
    // Extract text from response
    if (data.candidates && data.candidates.length > 0) {
      const content = data.candidates[0].content;
      if (content && content.parts && content.parts.length > 0) {
        return content.parts[0].text;
      }
    }
    
    throw new Error('Invalid response format from Gemini API - no content returned');
  } catch (error) {
    throw new Error(`Gemini API Error: ${error.message}`);
  }
};
import asyncHandler from 'express-async-handler';

// @desc    Get weather by coordinates
// @route   GET /api/weather?lat=...&lon=...
// @access  Private
export const getWeather = asyncHandler(async (req, res) => {
  const { lat, lon } = req.query;
  if (!lat || !lon) {
    res.status(400);
    throw new Error('Latitude and longitude are required');
  }

  const apiKey = process.env.OPENWEATHER_API_KEY;
  const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric`;

  const response = await fetch(url);
  const data = await response.json();

  if (data.cod !== 200) {
    res.status(data.cod);
    throw new Error(data.message);
  }

  const weatherData = {
    location: data.name,
    temperature: data.main.temp,
    feelsLike: data.main.feels_like,
    humidity: data.main.humidity,
    pressure: data.main.pressure,
    weather: data.weather[0].main,
    description: data.weather[0].description,
    windSpeed: data.wind.speed,
    icon: data.weather[0].icon,
    timestamp: new Date().toISOString(),
  };

  res.json(weatherData);
});
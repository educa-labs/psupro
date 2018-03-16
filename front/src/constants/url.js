let apiUrl;
if (process.env.NODE_ENV === 'production') {
  apiUrl = 'https://api.tuniversidad.cl';
} else if (process.env.NODE_ENV === 'development') {
  apiUrl = 'http://localhost:3000';
}

const apiExport = apiUrl;
export default apiExport;

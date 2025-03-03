// react-frontend/src/App.js

import React, { useState } from 'react';
import SearchForm from './components/SearchForm';
import ResultsDisplay from './components/ResultsDisplay';
import axios from 'axios';

function App() {
    const [results, setResults] = useState(null);
    const [error, setError] = useState("");

    const handleSearch = async (searchBy, searchValue) => {
        setError("");
        setResults(null);

        const apiUrl = "https://<your-apim-name>.azure-api.net/search";  // Replace with your actual APIM URL
        const apiKey = "<your-apim-key>";  // Replace with your actual APIM subscription key

        try {
            const response = await axios.post(
                apiUrl,
                { search_by: searchBy, search_value: searchValue },
                { headers: { 'Ocp-Apim-Subscription-Key': apiKey } }
            );

            setResults(response.data);
        } catch (err) {
            console.error("Search failed:", err);
            setError("Failed to fetch search results. Please check your connection or configuration.");
        }
    };

    return (
        <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
            <h1>DataPlatform Search Demo</h1>
            <SearchForm onSearch={handleSearch} />

            {error && <p style={{ color: "red" }}>{error}</p>}

            {results && <ResultsDisplay results={results} />}
        </div>
    );
}

export default App;

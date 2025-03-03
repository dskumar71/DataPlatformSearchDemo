// react-frontend/src/components/SearchForm.js

import React, { useState } from 'react';

function SearchForm({ onSearch }) {
    const [searchBy, setSearchBy] = useState("name");
    const [searchValue, setSearchValue] = useState("");

    const handleSearch = () => {
        onSearch(searchBy, searchValue);
    };

    return (
        <div style={{ marginBottom: "20px" }}>
            <label><strong>Search By:</strong></label>
            <select value={searchBy} onChange={(e) => setSearchBy(e.target.value)} style={{ marginLeft: "10px" }}>
                <option value="name">Name</option>
                <option value="id">ID</option>
            </select>

            <input
                type="text"
                placeholder={`Enter ${searchBy}`}
                value={searchValue}
                onChange={(e) => setSearchValue(e.target.value)}
                style={{ marginLeft: "10px" }}
            />

            <button onClick={handleSearch} style={{ marginLeft: "10px" }}>Search</button>
        </div>
    );
}

export default SearchForm;

// react-frontend/src/components/ResultsDisplay.js

import React from 'react';

function ResultsDisplay({ results }) {
    return (
        <div>
            <h3>Results from Fabric Database</h3>
            {results.FabricDatabase && results.FabricDatabase.length > 0 ? (
                results.FabricDatabase.map((record, index) => (
                    <div key={`fabric-${index}`} style={{ marginBottom: "10px", padding: "10px", border: "1px solid #ddd" }}>
                        <p><strong>ID:</strong> {record.ID}</p>
                        <p><strong>Name:</strong> {record.Name}</p>
                        <p><strong>Type:</strong> {record.Type}</p>
                        <p><strong>Created Date:</strong> {record.CreatedDate}</p>
                    </div>
                ))
            ) : (
                <p>No records found in Fabric Database.</p>
            )}

            <h3>Results from Blob Storage</h3>
            {results.BlobStorage && results.BlobStorage.length > 0 ? (
                results.BlobStorage.map((file, index) => (
                    <div key={`blob-${index}`} style={{ marginBottom: "10px", padding: "10px", border: "1px solid #ddd" }}>
                        <p><strong>File:</strong> {file.FileName}</p>
                        <p><strong>Name:</strong> {file.Name}</p>
                        <p><strong>ID:</strong> {file.ID}</p>
                        <p><strong>Tags:</strong> {file.Tags?.join(", ")}</p>
                        <a href={file.DownloadUrl} target="_blank" rel="noopener noreferrer">Download File</a>
                    </div>
                ))
            ) : (
                <p>No files found in Blob Storage.</p>
            )}
        </div>
    );
}

export default ResultsDisplay;

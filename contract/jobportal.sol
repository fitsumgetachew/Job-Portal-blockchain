// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobPortal {
    // Define data structures
    struct Applicant {
        uint256 id;
        string name;
        string skills;
        uint256 rating;
    }
    
    struct Job {
        uint256 id;
        string title;
        string description;
        string requirements;
        uint256 salary;
        address employer;
        bool filled;
    }
    
    // State variables
    mapping(uint256 => Applicant) public applicants;
    mapping(uint256 => Job) public jobs;
    uint256 public nextApplicantId;
    uint256 public nextJobId;
    
    // Events
    event NewApplicant(uint256 id, string name, string skills);
    event NewJob(uint256 id, string title, string description);
    event JobApplication(uint256 jobId, uint256 applicantId);
    event ApplicantRating(uint256 applicantId, uint256 rating);
    
    // Function to add a new applicant
    function addApplicant(string memory _name, string memory _skills) public {
        uint256 applicantId = nextApplicantId++;
        applicants[applicantId] = Applicant(applicantId, _name, _skills, 0);
        emit NewApplicant(applicantId, _name, _skills);
    }
    
    // Function to get applicant details
    function getApplicantDetails(uint256 _applicantId) public view returns (string memory, string memory, uint256) {
        require(_applicantId < nextApplicantId, "Applicant does not exist");
        Applicant memory applicant = applicants[_applicantId];
        return (applicant.name, applicant.skills, applicant.rating);
    }
    
    // Function to get applicant type
    function getApplicantType(uint256 _applicantId) public pure returns (string memory) {
        // Implement logic to determine applicant type based on id
        return "Unskilled"; // Placeholder
    }
    
    // Function to add a new job to the portal
    function addJob(string memory _title, string memory _description, string memory _requirements, uint256 _salary) public {
        uint256 jobId = nextJobId++;
        jobs[jobId] = Job(jobId, _title, _description, _requirements, _salary, msg.sender, false);
        emit NewJob(jobId, _title, _description);
    }
    
    // Function to get job details
    function getJobDetails(uint256 _jobId) public view returns (string memory, string memory, string memory, uint256, address, bool) {
        require(_jobId < nextJobId, "Job does not exist");
        Job memory job = jobs[_jobId];
        return (job.title, job.description, job.requirements, job.salary, job.employer, job.filled);
    }
    
    // Function for applicants to apply for a job
    function applyForJob(uint256 _jobId) public {
        require(_jobId < nextJobId, "Job does not exist");
        // Implement logic for applying for a job
        emit JobApplication(_jobId, uint256(uint160(msg.sender)));
    }
    
    // Function to provide a rating to an applicant
    function provideRating(uint256 _applicantId, uint256 _rating) public {
        require(_applicantId < nextApplicantId, "Applicant does not exist");
        require(_rating >= 0 && _rating <= 5, "Rating should be between 0 and 5");
        applicants[_applicantId].rating = _rating;
        emit ApplicantRating(_applicantId, _rating);
    }
    
    // Function to fetch applicant rating
    function getApplicantRating(uint256 _applicantId) public view returns (uint256) {
        require(_applicantId < nextApplicantId, "Applicant does not exist");
        return applicants[_applicantId].rating;
    }
}

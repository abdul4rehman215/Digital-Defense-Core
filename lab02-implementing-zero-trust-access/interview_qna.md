# 📘 Interview Q&A – Lab 02: Implementing Zero Trust Access

Q1. What is Zero Trust in cybersecurity?  
A: Zero Trust follows the principle of “never trust, always verify” for every access request.

Q2. How did you implement Zero Trust policies in this lab?  
A: By defining explicit access rules in a policy file and validating every request through a script.

Q3. What was the purpose of access_policy.conf?  
A: It stored user, resource, permission, time limit, and verification level for access decisions.

Q4. How did the policy manager script validate access?  
A: It matched user, resource, and permission against the policy file before granting access.

Q5. How were access decisions logged in this lab?  
A: All granted and denied requests were logged with timestamps in an access log file.

Q6. What does least privilege mean and how did you apply it?  
A: Granting only minimum required access, applied using strict chmod permissions on resources.

Q7. How did you verify file permissions were correctly enforced?  
A: By running a verification script and checking permission values using stat and ls -l.

Q8. What was the role of the access monitoring script?  
A: It created a baseline and detected unauthorized permission or ownership changes.

Q9. How did you test the complete Zero Trust implementation?  
A: Using an integration test script that validated policies, permissions, and monitoring together.

Q10. Why is automation important in Zero Trust architectures?  
A: Automation ensures consistent enforcement, continuous monitoring, and easier compliance validation.

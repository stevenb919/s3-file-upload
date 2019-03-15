# S3 File Upload Test

Uploads a file to S3 without any credentials, using IAM Role.  
Assumes that the EC2 instance has the correct IAM Role.

1. Create a new IAM role with the following policy.  Make sure to
create a bucket with the same name or change the name here and in index.js.

    Policy to allow upload to a specific bucket
    ```
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::sb.buckettest.3.2019/*"
            }
        ]
    }
    ```
2. Create new EC2 instance, select IAM role you created above.
3. Past user-data.sh into user data and create EC2
4. Check your bucket to see the uploaded file named test.csv

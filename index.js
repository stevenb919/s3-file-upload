/**
 * Uploads a file to S3 without any credentials, using IAM Role.
 * Assumes that the EC2 instance has the correct IAM Role, see README.md
 * for instructions.
 */
const AWS = require('aws-sdk'),
    fs = require('fs')

AWS.config.apiVersions = {
  s3: '2006-03-01',
}

const S3 = new AWS.S3()
const bucketName = 'sb.buckettest.3.2019'
const fileName = 'test.csv'

fs.readFile(fileName, (err, data) => {
  if (err) throw err

  const base64data = new Buffer(data, 'binary')

  const params = {
    Bucket: bucketName,
    Key: fileName,
    Body: base64data
  }

  S3.putObject(params, function(err, data) {
    if (err) console.log(err, err.stack)
    else console.log(data)
  })
})
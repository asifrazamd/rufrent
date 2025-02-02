const { S3Client, ListObjectsV2Command ,PutObjectCommand } = require('@aws-sdk/client-s3');
const sharp = require('sharp');

class S3Service {
  constructor() {
    this.s3 = new S3Client({ region: process.env.AWS_REGION });
  }

  async uploadImages(files, propertyId) {
    if (!propertyId) {
      throw new Error('Property ID is required for uploading images.');
    }

    const folderName = `property-images/${propertyId}`;

    const uploadImagePromises = files.map(async (file) => {
      try {
        const resizedImageBuffer = await sharp(file.buffer)
          .resize(800,600)
          .toBuffer();        

        const command = new PutObjectCommand({
          Bucket: process.env.AWSS3_BUCKET_NAME,
          Key: `${folderName}/${file.originalname}`,
          Body: resizedImageBuffer,
          ContentType: file.mimetype,
        });

        await this.s3.send(command);
        console.log(`Successfully uploaded ${file.originalname}`);

      } catch (error) {
        console.error('Error resizing or uploading image:', error);
        throw new Error(`Error processing image ${file.originalname}: ${error.message}`);
      }
    });

    try {
      await Promise.all(uploadImagePromises);
      const folderUrl = `https://${process.env.AWSS3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${folderName}/`;
      return folderUrl;
    } catch (error) {
      console.error('Error during batch upload:', error);
      throw new Error('Failed to upload images to S3: ' + error.message);
    }
  }
  async getS3Images(folderUrl) {
    try {
        const bucketName = process.env.AWSS3_BUCKET_NAME;
        const prefix = folderUrl.replace(
            `https://${bucketName}.s3.${process.env.AWS_REGION}.amazonaws.com/`,
            ""
        );

        const command = new ListObjectsV2Command({
            Bucket: bucketName,
            Prefix: prefix,
        });

        const { Contents } = await this.s3.send(command);

        if (!Contents || Contents.length === 0) {
            return [];
        }

        return Contents.map((file) => 
            `https://${bucketName}.s3.${process.env.AWS_REGION}.amazonaws.com/${file.Key}`
        );
    } catch (error) {
        console.error("Error fetching images from S3:", error);
        return [];
    }
}



}

module.exports = new S3Service();

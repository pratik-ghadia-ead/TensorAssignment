//
//  UploadImageViewModel.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import UIKit
import FirebaseStorage

class UploadImageViewModel {
    func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(UploadImageError.imageDataConversion))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageName = "\(UUID().uuidString).jpg"
        let imagesRef = storageRef.child("images/\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = imagesRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                imagesRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        completion(.success(downloadURL))
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

enum UploadImageError: Error {
    case imageDataConversion
}

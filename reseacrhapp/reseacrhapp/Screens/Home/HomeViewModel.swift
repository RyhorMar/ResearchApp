//
//  HomeViewModel.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/26/24.
//

import ResearchKit

enum Constansts {
    static let kIdentifierName = "kIdentifierName"
    static let kIdentifierAge = "kIdentifierAge"
    static let kIdentifierEmail = "kIdentifierEmail"
    static let kIdentifierCategories = "kIdentifierCategories"
    static let kIdentifierTask = "kIdentifierTask"
}

final class HomeViewModel {
    private let databaseService: DatabaseService = RealmDatabaseService()
    
    private(set) var content: [User] = []

    public func loadData(completion: () -> Void) {
        content = databaseService.userList()
        completion()
    }

    public func save(user: User) {
        databaseService.save(model: user)
    }

    public func user(with taskResult: ORKTaskResult) -> User? {
        guard let nameTextQuestionResult = taskResult
            .stepResult(forStepIdentifier: Constansts.kIdentifierName)?
            .firstResult as? ORKTextQuestionResult,
              let name = nameTextQuestionResult.answer as? String else {
            return nil
        }
        guard let ageNumericQuestionResult = taskResult
            .stepResult(forStepIdentifier: Constansts.kIdentifierAge)?
            .firstResult as? ORKNumericQuestionResult,
              let age = ageNumericQuestionResult.answer as? Int else {
            return nil
        }
        guard let emailTextQuestionResult = taskResult
            .stepResult(forStepIdentifier: Constansts.kIdentifierEmail)?
            .firstResult as? ORKTextQuestionResult,
              let email = emailTextQuestionResult.answer as? String else {
            return nil
        }
        guard let categoriesChoiceQuestionResult = taskResult
            .stepResult(forStepIdentifier: Constansts.kIdentifierCategories)?
            .firstResult as? ORKChoiceQuestionResult,
              let categoriesIndexes  = categoriesChoiceQuestionResult.answer as? [NSNumber] else {
            return nil
        }
        let categories : [String] = categoriesIndexes.map({databaseService.allCategories()[$0.intValue]})
        let json: [AnyHashable : Any] = [
            "id": UUID().uuidString,
            "name": name,
            "age": "\(age)",
            "email": email,
            "categories": categories,
        ]
        return User(dictionary: json)
    }

    public func taskWithStepsToAddUser() -> ORKOrderedTask {
        /// configure  Name Step
        let nameFormat = ORKTextAnswerFormat()
        let nameStep = ORKQuestionStep.init(
            identifier: Constansts.kIdentifierName,
            title: "Name",
            question: "What is your name?",
            answer: nameFormat)
        
        /// configure  Age Step
        let ageFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "years")
        ageFormat.minimum = NSNumber(value: 0)
        ageFormat.maximum = NSNumber(value: 130)
        let ageStep = ORKQuestionStep.init(
            identifier: Constansts.kIdentifierAge,
            title: "Age",
            question: "How old are you?",
            answer: ageFormat)
        
        /// configure  Email  Step
        let emailFormat = ORKTextAnswerFormat()
        let emailStep = ORKQuestionStep.init(
            identifier: Constansts.kIdentifierEmail,
            title: "Email",
            question: "What is your email?",
            answer: emailFormat)
        
        /// configure  Categories  Step
        var textChoices = [ORKTextChoice]()
        let categories = databaseService.allCategories()
        for index in 0..<categories.count {
            let textChoice = ORKTextChoice.init(text: categories[index], value: NSNumber(value: index))
            textChoices.append(textChoice)
        }
        let categoryFormat = ORKTextChoiceAnswerFormat(
            style: .multipleChoice,
            textChoices: textChoices
        )
        let categoryStep = ORKQuestionStep.init(
            identifier: Constansts.kIdentifierCategories,
            title: "Categories",
            question: "Could you please chose categories!",
            answer: categoryFormat)
        
        /// configure task from Steps
        let task = ORKOrderedTask(identifier: Constansts.kIdentifierTask, steps: [
            nameStep,
            ageStep,
            emailStep,
            categoryStep
        ]
        )
        
       return task
    }
}

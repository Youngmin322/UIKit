//
//  CoreDataManager.swift
//  ToDoList_UIKit
//
//  Created by 조영민 on 3/21/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("CoreData 스토어 로드 실패: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                print("CoreData 저장 실패: \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: CRUD 설계
    
    // 모든 할 일 가져오기
    func fetchTodos() -> [Todo] {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortByDate = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortByDate]
        
        do {
            return try context.fetch(request)
        } catch {
            print("할 일 가져오기 실패: \(error)")
            return []
        }
    }
    
    // 할 일 생성
    func createTodo(title: String, content: String, dueDate: Date) -> Todo {
        let todo = Todo(context: context)
        todo.id = UUID()
        todo.title = title
        todo.content = content
        todo.dueDate = dueDate
        todo.isCompleted = false
        todo.createdAt = Date()
        
        saveContext()
        return todo
    }
    
    // 할 일 업데이트
    func updateTodo(_ todo: Todo) {
        saveContext()
    }
    
    // 할 일 삭제
    func deleteTodo(_ todo: Todo) {
        context.delete(todo)
        saveContext()
    }
}

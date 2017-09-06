//: Playground - noun: a place where people can play

// WIFI Password: 4875esubwireless

import UIKit

//Error Handling Strategy
//1. Create an enum with possible errors
enum EnterTimeError: LocalizedError {
	case endDateBeforeStartDate(startDate: Date, endDate: Date)
	case databaseSaveFailed

	var localizedDescription: String {
		switch self {
		case .endDateBeforeStartDate(let start, let end):
			return "Start:\(start.debugDescription), end: \(end.debugDescription)"
		case .databaseSaveFailed:
			return "database save failed"
		}
	}
}

//2. Mark our function as a throwing function
func enterTime(start: Date, end: Date) throws -> Double {

	//What can go wrong?
	//1. end date before start date
	guard start < end else {
		throw EnterTimeError.endDateBeforeStartDate(startDate: start, endDate: end)
	}

	//2. error saving to database
	try pretendSaveToDatabase()

	return end.timeIntervalSince(start)
}

enum DatabaseSaveError: LocalizedError {
	case userNotFound
	case databaseNotFound
	case storageFull
	case unknownError

	var localizedDescription: String {
		switch self {
		case .userNotFound:
			return "user not found"
		case .databaseNotFound:
			return "database not found"
		case .storageFull:
			return "storage full"
		case .unknownError:
			return "unknown error"
		}
	}
}

func pretendSaveToDatabase() throws {
	// Do stuff...save to database

	throw DatabaseSaveError.storageFull
}

let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 4)

do {

	let seconds = try enterTime(start: startDate, end: endDate)

	let hours = seconds / 3600.0

} catch let error as EnterTimeError {

	print(error.localizedDescription)

} catch let error as DatabaseSaveError {

	print(error.localizedDescription)

}

enum SomeResult {
	case success(Data)
	case failure(Error)
}


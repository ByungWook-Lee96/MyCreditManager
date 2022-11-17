
import Foundation

// while 루프문 나가는 변수
var exit:Bool = true

// 학생 딕셔너리
var studentName = [String:[[String]]]()  // 딕셔너리 안에 값은 2차원배열 삽입

// 학생 추가 함수
func AddStudent(student: String!){
    // 키 하나씩 출력되는 for문
    for key in studentName.keys{
        // 키와 학생이름이 같으면 추가X
        if key == student{
            print(student + "는(은) 이미 존재하는 학생입니다. 추가하지 않습니다. ")
            return
        }
    }
    // 키와 학생이름이 같지 않으면 학생이름 studentName 딕셔너리에 추가
    studentName[student] = []  // nil 사용하면 student 키가 지워짐
}

// 학생 삭제 함수
func RemoveStudent(student: String){
    // 키 하나씩 출력되는 for문
    for key in studentName.keys{
        // 키와 학생이름이 같으면 학생 삭제
        if key == student{
            print(student + " 학생을 삭제하였습니다.")
            // studentName[key] = nil  // 이것도 가능한데 모든 student 강제 형변환해야되서 removeValue 사용
            studentName.removeValue(forKey: student)
            return
        }
    }
    // studentName 딕셔너리에 학생이름 없는 것
    print(student + " 학생을 찾지 못했습니다.")
}

// 과목 & 성적 추가 함수
func AddSubjectGrade(student: String, subject: String, grade: String){
    
    // studentName 딕셔너리에 학생이름 없는 것
    if studentName[student] == nil{
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    let count = studentName[student]!.count  // optional을 지우기 위해서 count 상수에 넣음
    // value에 해당하는 부분의 카운트
    for i in 0..<count{
        // 해당 키의 value와 subject가 같으면 grade를 업데이트
        if studentName[student]?[i][0] == subject{
            studentName[student]?[i][1] = grade
            print(student + " 학생의 " + subject + " 과목이 " + grade + "로 변경되었습니다.")
            return
        }
    }
    // 해당 키의 value가 없으면 subject와 grade 추가
    studentName[student]!.append([subject, grade])
    print(student + " 학생의 " + subject + " 과목이 " + grade + "로 추가되었습니다.")
    return
}

// 성적 삭제
func RemoveGrade(student: String, subject: String){
    
    let count = studentName[student]!.count // optional을 지우기 위해서 count 상수에 넣음
    // value에 해당하는 부분의 카운트
    for i in 0..<count{
        // 해당 키의 value와 subject가 같으면 grade에 -1 출력 -> 수정이 필요할 수 있음
        if studentName[student]?[i][0] == subject{
            studentName[student]?.remove(at: i)
            return
        }
    }
    // studentName 딕셔너리에 학생이름 없는 것
    print("입력이 잘못되었습니다. 다시 확인해주세요.")
    return
    
}

// 평점 보기
func Average(student: String){

    let count = studentName[student]!.count  // optional을 지우기 위해서 count 상수에 넣음
    var sum: Double = 0  // 평점 총합을 구하기 위한 sum
    var validSubject = 0
    print(student)
    // value에 해당하는 부분의 카운트
    for i in 0..<count{
        // Calculate 함수에서 나온 결과가 -1이면 해당 과목만 미출력
        if Calculate(num: i, key: student) == -1{
            print(studentName[student]![i][0] + " : " + studentName[student]![i][1])
            print(studentName[student]![i][1] + "는 잘못된 성적입니다. A+ ~ F 사이의 문자로 성적을 변경하세요.")
        }else{
            print(studentName[student]![i][0] + " : " + studentName[student]![i][1])
            sum += Calculate(num: i, key: student)
            validSubject += 1
        }
    }
    print("평점 : \(sum/Double(validSubject))")
    return

}

// 성적별 점수 계산 함수
func Calculate(num: Int, key: String) -> Double{
    switch(studentName[key]![num][1]){
    case "A+":
        return 4.5
    case "A":
        return 4
    case "B+":
        return 3.5
    case "B":
        return 3
    case "C+":
        return 2.5
    case "C":
        return 2
    case "D+":
        return 1.5
    case "D":
        return 1
    case "F":
        return 0
    // 위에 문자가 아닌 경우는 무조건 미출력
    default:
        return -1
    }
}

// 지워야 하는 함수 studentName 딕셔너리 출력되는 함수
func PrintDictionary(){
    for key in studentName.keys{
        print(key)
        print(studentName[key]!)
    }
}

// "X"를 입력하기 전까지 무한으로 반복되는 while문
while exit{
    print("""
          원하는 기능을 입력해주세요
          1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, P: 전체 학생 확인, X: 종료
          (단, 영어와 숫자만 입력 가능)
          """)
    
    let input = readLine()
    
    switch(input){
        // 학생 추가
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            let student = readLine()
            AddStudent(student: student)
        // 학생 삭제
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            let student = readLine()
            RemoveStudent(student: student!)
        // 성적 추가
        case "3":
            print("""
                성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift A+
                만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                """)
            let array = readLine()!.split(separator: " ").map { String($0) } // 3개 단어 입력 안한 경우 만들어야 함
            let student = array[0]
            let subject = array[1]
            let grade = array[2]
            AddSubjectGrade(student: student, subject: subject, grade: grade)
        // 성적 삭제
        case "4":
            print("""
                성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift
                """)
            let array = readLine()!.split(separator: " ").map { String($0) }
            let student = array[0]
            let subject = array[1]
            RemoveGrade(student: student, subject: subject)
        // 평점 구하기
        case "5":
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
            let student = readLine()
            Average(student: student!)
        // 프로그램 종료
        case "X":
            print("프로그램을 종료합니다...")
            exit = false
        // 딕셔너리 안에 값 모두 출력
        case "P":
            PrintDictionary()
        // 잘못 입력된 경우
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

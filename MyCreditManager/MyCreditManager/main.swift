
import Foundation

// while 루프문 나가는 변수
var exit:Bool = true

// 학생 딕셔너리
var studentName = [String:[[String]]]()

// 학생 추가 함수
func AddStudent(student: String!){
    for key in studentName.keys{
        if key == student{
            print(student + "는(은) 이미 존재하는 학생입니다. 추가하지 않습니다. ")
            return
        }
    }
    print(student!)  // 지우기
    studentName[student] = []  // nil 사용하면 안됨
}

// 과목 & 성적 추가 함수
func AddSubjectGrade(student: String, subject: String, grade: String){
    for key in studentName.keys{
        if key == student{
            studentName[student]!.append([subject, grade])
            return
        }
    }
    print("입력이 잘못되었습니다. 다시 확인해주세요.")
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
          1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
          """)
    
    let input = readLine()
    
    switch(input){
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            let student = readLine()
            AddStudent(student: student)
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
        case "3":
            print("""
                성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift A+
                만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                """)
            let array = readLine()!.split(separator: " ").map { String($0) }
            let student = array[0]
            let subject = array[1]
            let grade = array[2]
            AddSubjectGrade(student: student, subject: subject, grade: grade)
        case "4":
            print("""
                성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift
                """)
        case "5":
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
        case "X":
            print("프로그램을 종료합니다...")
            exit = false
        case "Y":
            PrintDictionary()
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

// Reference: 
//   http://stackoverflow.com/questions/2624192/good-hash-function-for-strings
//   http://grepcode.com/file/repository.grepcode.com/java/root/jdk/openjdk/6-b14/java/lang/String.java#String.hashCode%28%29
#include <iostream>
#include <ctime>
#include <vector>
#include <string>
#include <cstdio>
#include <map>
using namespace std;

#define TEST_COLLISION

string getRandString(int max_length) {
	string word("bool");
	// string word;
	// Not to return null string
	int len = rand() % max_length;
	if(len == 0) len = 1;
    for(int i=0; i<len; ++i) {
		int v = rand() % 255;
		char c = (char)(v);
		word.push_back(c);
	}
	return word;
}

vector<string> getStringVec(int nStr, int strLengthMax) {
    vector<string> vStr;
    for(int i=0; i<nStr; ++i)
		vStr.push_back(getRandString(strLengthMax));
	return vStr;
}

typedef int (*hash_func)(string, int);

int djb2Hash(string s, int hash_size) {
	unsigned int hash = 5381;
	for(int i=0; i<s.size(); ++i)
		hash = ((hash << 5) + hash) + (int)(s[i]);
	return hash;
}
/* c.f. java hash code */
int javaHash(string s, int hash_size) {
	static int hash = 0;
	int h = hash;

	if(h == 0) {
//		int off = hash_size;
		int off = 0;
		int len = s.size();

		for(int i=0; i<len; ++i) {
			h = 31*h + (int)(s[i]);
		}
		h %= hash_size;
//		hash = h;
	}
	return h;
}
int simpleHash(string s, int hash_size) {
	int hash = 7;
	for(int i=0; i<s.size(); ++i) {
		hash = hash*31 + (int)s[i];
		hash %= hash_size;
	}
    return hash;
}

int main(int argc, char** argv) {

	srand( time(NULL) );
	int nWord = 1000;
	if(argc == 2) nWord = atoi(argv[1]);
	int szHash = nWord * 4;
	const int string_length_max = 17;

	vector<string> vs = getStringVec(nWord, string_length_max);


//	for(int i=0; i<nWord; ++i)
//		cout << vs[i] << endl;


	map<int, string> strMap;
	int nCollision = 0;
	for(int i=0; i<vs.size(); ++i) {
		int hash_key = djb2Hash(vs[i], szHash);
//		int hash_key = simpleHash(vs[i], szHash);
//		cout << hash_key << endl;
#ifdef TEST_COLLISION
		map<int, string>::iterator it;
		if((it = strMap.find(hash_key)) != strMap.end())
			++nCollision;
		else 
		    strMap.insert(make_pair(hash_key, vs[i]));
#endif // TEST_COLLISION
    }

#ifdef TEST_COLLISION
    cout << "Word number = " << nWord << endl;
	cout << "Hash size = " << szHash << endl;
	cout << "Map size = " << strMap.size() << endl;
    cout << "Number of collisions = " << nCollision << endl;
	cout << "Percentage = " << 100*(double)nCollision/(double)nWord << "%" << endl;
#endif // TEST_COLLISION


	return 0;
}

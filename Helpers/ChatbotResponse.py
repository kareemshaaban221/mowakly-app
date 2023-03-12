import re

class ChatbotResponse:
    def __init__(self, model):
        self.__model = model
        
    # Used to get the response
    def get_response(self, user_input):
        split_message = re.split(r'\s+|[,;?!.-]\s*', user_input.lower())
        response = self.__check_all_messages(split_message)
        ans = self.__model.classify(user_input)[0]
        if ans == 'شات' or len(user_input.split()) < 2:
            return response
        else:
            return 'القضية دي تصنيفها'+' '+'('+ ans +')' + ' ' + 'هل ترغب في محامي ؟'
    
    def welcome(self):
        return [
            'اهلا بيك يافندم انا موكلي شات بوت !',
            'انا ممكن اساعدك تعرف تصنيف قضيتك كل الي عليك تعمله تكتب مشكلتك او قضيتك وانا هاصنفهالك الي اسره او مدني او جنح !',
            'وكمان هارشحلك المحاميين المتخصصين في نوع القضية الخاصة بيك ! '
        ]
    
    def __unknown(self):
        response = " مش فاهم , انا ممكن اساعدك تعرف تصنيف قضيتك كل الي عليك تعمله تكتب مشكلتك او قضيتك وانا هاصنفهالك الي اسره او مدني او جنح !"
        return response

    def __message_probability(self,user_message, recognised_words, single_response=False, required_words=[]):
        message_certainty = 0
        has_required_words = True

        # Counts how many words are present in each predefined message
        for word in user_message:
            if word in recognised_words:
                message_certainty += 1

        # Calculates the percent of recognised words in a user message
        percentage = float(message_certainty) / float(len(recognised_words))

        # Checks that the required words are in the string
        for word in required_words:
            if word not in user_message:
                has_required_words = False
                break

        # Must either have the required words, or be a single response
        if has_required_words or single_response:
            return int(percentage * 100)
        else:
            return 0


    def __check_all_messages(self,message):
        highest_prob_list = {}

        # Simplifies response creation / adds it to the dict
        def response(bot_response, list_of_words, single_response=False, required_words=[]):
            nonlocal highest_prob_list
            highest_prob_list[bot_response] = self.__message_probability(message, list_of_words, single_response, required_words)

        # Responses -------------------------------------------------------------------------------------------------------
        response('مساء الخير يافندم !!', ['اهلا','عليكم', 'السلام', 'مرحبا', 'مساء','الخير', "صباح"], single_response=True)
        response('مع السلامة يافندم', ['سلام','السلامة','مع','الي'], single_response=True)
        response('انا كويس , وانت عامل ايه؟', ['عامل', 'ايه'], required_words=['عامل'])
        response('تمام يافندم اقدر اساعدك في حاجة تاني ؟', ['شكرا','تمام'], single_response=True)
        response('شرفتنا جدا يافندم , مع السلامة', ['لا'], single_response=True)
        response('شكرا جدا يافندم!', ['انا', 'بحبك'], required_words=['بحبك'])
        response('انا هنا عشان اساعدك , اتفضل', ['انا','مشكلة','عندي'], required_words=['مشكلة'])
        response('انا هنا عشان اساعدك , اتفضل!!', ['انا','قضية','عندي'], required_words=['قضية'])
        response('تستاهل الحمد', ['الله', 'الحمد'], required_words=['الحمد','الله'])
        response('انا كويس , وانت عامل ايه؟', ['ازيك'], required_words=['ازيك'])

        

        best_match = max(highest_prob_list, key=highest_prob_list.get)
        # print(highest_prob_list)
        # print(f'Best match = {best_match} | Score: {highest_prob_list[best_match]}')

        return self.__unknown() if highest_prob_list[best_match] < 1 else best_match
    
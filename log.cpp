"redis.log(redis.LOG_NOTICE, 'start process --------------------------')\
                          for x, y in ipairs(KEYS) do\
                              redis.log(redis.LOG_NOTICE, 'KEYS index:', x, 'value:', y)\
                          end\
                          for x, y in ipairs(ARGV) do\
                              redis.log(redis.LOG_NOTICE, 'ARGV index:', x, 'value:', y)\
                          end\
                          for i = 2, #KEYS - 1, 2 do\
                              if not redis.call('HGET', KEYS[1], KEYS[i]) then\
                                  redis.log(redis.LOG_NOTICE, 'add room', KEYS[i], ' data:', KEYS[i + 1])\
                                  redis.call('HSET', KEYS[1], KEYS[i], KEYS[i + 1])\
                              end\
                          end\
                          local all_rooms = redis.call('HGETALL', KEYS[1])\
                          local roomid_ret = '0'\
                          local min_capacity = 99999999\
                          local min_room_json\
                          redis.log(redis.LOG_NOTICE, 'all_rooms length:', #all_rooms)\
                          for a, b in ipairs(all_rooms) do\
                              redis.log(redis.LOG_NOTICE, 'all_rooms index:', a, 'value:', b)\
                          end\
                          for i, j in ipairs(all_rooms) do\
                              if i % 2 == 1 and string.match(ARGV[1], ',' .. j .. ',') then\
                                  local room_json = cjson.decode(all_rooms[i + 1])\
                                  for i, j in pairs(room_json) do\
                                      redis.log(redis.LOG_NOTICE, 'i::', i, 'j::', j)\
                                  end\
                                  if room_json['conference'] == 0 and room_json['capacity'] < min_capacity then\
                                      min_capacity = room_json['capacity']\
                                      roomid_ret = j\
                                      min_room_json = room_json\
                                  end\
                              end\
                          end\
                          if roomid_ret ~= '0' then\
                              local new_room = {\
                                  id = min_room_json['id'],\
                                  name = min_room_json['name'],\
                                  capacity = min_room_json['capacity'],\
                                  conference = tonumber(ARGV[2])\
                              }\
                              if redis.call('HSET', KEYS[1], roomid_ret, cjson.encode(new_room)) then\
                                  redis.log(redis.LOG_NOTICE, 'alloc:', roomid_ret)\
                                  return roomid_ret\
                              else\
                                  return '0'\
                              end\
                          end\
                          redis.log(redis.LOG_NOTICE, 'failed roomid_ret', roomid_ret)\
                          return '0'\
                          "
